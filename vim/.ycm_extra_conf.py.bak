import os
import os.path
import fnmatch
import logging
import ycm_core
import re

BASE_FLAGS = [
        '-Wall',
        '-Wextra',
        '-Werror',
        '-Wno-long-long',
        '-Wno-variadic-macros',
        '-fexceptions',
        '-ferror-limit=10000',
        '-DNDEBUG',
        '-std=c++14',
        '-xc++',
        '-I/usr/lib/',
        '-I/usr/include/'
        ]

SOURCE_EXTENSIONS = [
        '.cpp',
        '.cxx',
        '.cc',
        '.c',
        '.m',
        '.mm'
        ]

SOURCE_DIRECTORIES = [
        'src',
        'lib'
        ]

HEADER_EXTENSIONS = [
        '.h',
        '.hxx',
        '.hpp',
        '.hh'
        ]

HEADER_DIRECTORIES = [
        'include'
        ]

BUILD_DIRECTORY = 'build';

def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS

def GetCompilationInfoForHeaderRos(headerfile, database):
    """Return the compile flags for the corresponding src file in ROS

    Return the compile flags for the source file corresponding to the header
    file in the ROS where the header file is.
    """
    try:
        import rospkg
    except ImportError:
        return None
    pkg_name = rospkg.get_package_name(headerfile)
    if not pkg_name:
        return None
    try:
        pkg_path = rospkg.RosPack().get_path(pkg_name)
    except rospkg.ResourceNotFound:
        return None
    filename_no_ext = os.path.splitext(headerfile)[0]
    hdr_basename_no_ext = os.path.basename(filename_no_ext)
    for path, dirs, files in os.walk(pkg_path):
        for src_filename in files:
            src_basename_no_ext = os.path.splitext(src_filename)[0]
            if hdr_basename_no_ext != src_basename_no_ext:
                continue
            for extension in SOURCE_EXTENSIONS:
                if src_filename.endswith(extension):
                    compilation_info = database.GetCompilationInfoForFile(
                        path + os.path.sep + src_filename)
                    if compilation_info.compiler_flags_:
                        return compilation_info
    return None

def GetCompilationInfoForFile(database, filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            # Get info from the source files by replacing the extension.
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = database.GetCompilationInfoForFile(replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
            # If that wasn't successful, try replacing possible header directory with possible source directories.
            for header_dir in HEADER_DIRECTORIES:
                for source_dir in SOURCE_DIRECTORIES:
                    src_file = replacement_file.replace(header_dir, source_dir)
                    if os.path.exists(src_file):
                        compilation_info = database.GetCompilationInfoForFile(src_file)
                        if compilation_info.compiler_flags_:
                            return compilation_info
        # Look in the ROS package
        compilation_info = GetCompilationInfoForHeaderRos(database, filename)
        if compilation_info:
            return compilation_info
        return None
    return database.GetCompilationInfoForFile(filename)

def FindNearest(path, target, build_folder=None):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        logging.info("Found nearest " + target + " at " + candidate)
        return candidate;

    parent = os.path.dirname(os.path.abspath(path));
    if(parent == path):
        raise RuntimeError("Could not find " + target);

    if(build_folder):
        candidate = os.path.join(parent, build_folder, target)
        if(os.path.isfile(candidate) or os.path.isdir(candidate)):
            logging.info("Found nearest " + target + " in build folder at " + candidate)
            return candidate;

    return FindNearest(parent, target, build_folder)

def GetRosIncludePaths():
    """Return a list of potential include directories

    The directories are looked for in $ROS_WORKSPACE.
    """
    try:
        from rospkg import RosPack
    except ImportError:
        return []
    rospack = RosPack()
    includes = []
    includes.append(os.path.expandvars('$ROS_WORKSPACE') + '/devel/include')
    for p in rospack.list():
        if os.path.exists(rospack.get_path(p) + '/include'):
            includes.append(rospack.get_path(p) + '/include')
            logging.ino("Found ROS package: " + p)
    for distribution in os.listdir('/opt/ros'):
        includes.append('/opt/ros/' + distribution + '/include')
        logging.info("Found ROS distro: " + distribution)
    return includes


def GetRosIncludeFlags():
    logging.info("In GetRosIncludeFlags()")
    includes = GetRosIncludePaths()
    flags = []
    flagStr = ""
    for include in includes:
        flags.append('-isystem')
        flags.append(include)
        flagStr = flagStr + include + " "
    logging.info("Found ROS flags: " + flagStr )
    return flags

def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[ len(path_flag): ]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags


def FlagsForClangComplete(root):
    try:
        clang_complete_path = FindNearest(root, '.clang_complete')
        clang_complete_flags = open(clang_complete_path, 'r').read().splitlines()
        return clang_complete_flags
    except:
        return None

def FlagsForInclude(root):
    try:
        include_path = FindNearest(root, 'include')
        flags = []
        for dirroot, dirnames, filenames in os.walk(include_path):
            for dir_path in dirnames:
                real_path = os.path.join(dirroot, dir_path)
                flags = flags + ["-I" + real_path]
        return flags
    except:
        return None

def FlagsForCompilationDatabase(root, filename):
    try:
        try:
            import rospkg
        except ImportError:
            return ''
        pkg_name = rospkg.get_package_name(filename)
        if pkg_name:
            compilation_db_dir = (os.path.expandvars('$ROS_WORKSPACE') +
                   os.path.sep +
                   'build' +
                   os.path.sep +
                   pkg_name)
        else:
            # Last argument of next function is the name of the build folder for
            # out of source projects
            compilation_db_path = FindNearest(root, 'compile_commands.json', BUILD_DIRECTORY)
            compilation_db_dir = os.path.dirname(compilation_db_path)
        logging.info("Set compilation database directory to " + compilation_db_dir)
        compilation_db =  ycm_core.CompilationDatabase(compilation_db_dir)
        if not compilation_db:
            logging.info("Compilation database file found but unable to load")
            return None
        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            logging.info("No compilation info for " + filename + " in compilation database")
            return None
        return MakeRelativePathsInFlagsAbsolute(
                compilation_info.compiler_flags_,
                compilation_info.compiler_working_dir_)
    except:
        return None

def FlagsForFile(filename):
    root = os.path.realpath(filename);
    final_flags = BASE_FLAGS + GetRosIncludeFlags()
    compilation_db_flags = FlagsForCompilationDatabase(root, filename)
    if compilation_db_flags:
        final_flags = final_flags + compilation_db_flags
    else:
        clang_flags = FlagsForClangComplete(root)
        if clang_flags:
            final_flags = final_flags + clang_flags
        include_flags = FlagsForInclude(root)
        if include_flags:
            final_flags = final_flags + include_flags
    return {
            'flags': final_flags,
            'do_cache': True
            }
