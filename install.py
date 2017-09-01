#! /usr/bin/env python

"""
This is the dotfile installer of Bart van Nierop's dotfiles.
It takes a list of files and folders in the repository. Then
it tries to symlink all of them.

A special exception is made for files and folders that contain
the suffix .windows or .linux. These dotfiles are platform
specific. This installer will detect these suffixes and only symlink
the platform specific one, naming it's link without the suffix.
For example, .gitconfig.linux will be symlinked to ~/.gitconfig on
Linux, while it will be ignored on Windows.
"""

import os
import platform

###########################################################################
# Enums in python 
###########################################################################
def CreateEnum(**kwargs):
    return type('Enum', (), kwargs)

###########################################################################
# Some config
###########################################################################
Ignore = [ __file__ if not __file__.startswith('./') else __file__[2:], '.git', '.gitignore' ]

###########################################################################
# Constants
###########################################################################
OsNames = CreateEnum(LINUX='linux', WINDOWS='windows', MAC='darwin')

###########################################################################
# Ensure that os.symlink exists on both Linux and Windows.
###########################################################################
os_symlink = getattr(os, 'symlink', None)
if not callable(os_symlink):
    def symlink_ms(source, link_name):
        import ctypes
        csl = ctypes.windll.kernel32.CreateSymbolicLinkA
        csl.argtypes = (ctypes.c_char_p, ctypes.c_char_p, ctypes.c_uint32)
        csl.restype = ctypes.c_ubyte
        flags = 1 if os.path.isdir(source) else 0
        if csl(link_name, source, flags) == 0:
            raise ctypes.WinError()
    os.symlink = symlink_ms

###########################################################################
# Utilities
###########################################################################
def ScriptDir():
    """Return the folder that the installer is in."""
    return os.path.dirname(os.path.abspath(__file__))

def ListFiles(path):
    """List all files in the given path."""
    try:
        return os.listdir(path)
    except OSError as error:
        raise IOError(*error.args)

def IsOsSpecificFileName(fileName, osNames):
    """Test whether the given fileName has an os specific suffix."""
    lowercaseOsNames = [name.lower() for name in osNames]
    fileExt = FileExt(fileName.lower())
    return fileExt in lowercaseOsNames

def FileExt(fileName):
    """Get extension of the given filename, without the period."""
    _, fileExt = os.path.splitext(fileName)
    if fileExt.startswith('.'):
        fileExt = fileExt[1:]
    return fileExt

def ScriptDirPath(fileName):
    """Returns the given file name inside the installer folder."""
    return os.path.join(ScriptDir(), fileName)

def HomeDirPath(fileName, osNames, currentOs):
    """Returns the given file name inside the user's home folder."""
    name = fileName
    if (IsOsSpecificFileName(fileName, osNames)):
        name = ''.join(fileName.rsplit('.' + currentOs, 1))
    return os.path.join(os.path.expanduser('~'), name)

###########################################################################
# Install
###########################################################################
def Install():
    """All the installer logic. Most of this is described at the top of this file.
    Whenever creation of a symbolic link fails, installation is cancelled and rolled back."""
    osNames = [OsNames.LINUX, OsNames.WINDOWS, OsNames.MAC]
    currentOs = platform.system().lower()
    names = ListFiles(ScriptDir())
    filteredNames = [name for name in names if ShouldIncludeFile(name, osNames, currentOs, Ignore)]

    functions = [(CreateLinkFunction(ScriptDirPath(name), HomeDirPath(name, osNames, currentOs)),
        CreateUndoFunction(HomeDirPath(name, osNames, currentOs))) for name in filteredNames]

    undoFunctions = []
    errors = []

    for perform, undo in functions:
        try:
            perform()
            undoFunctions.append(undo)
        except Exception as e:
            # import traceback
            # errors.append((e, traceback.format_exc()))
            errors.append(e)
            print 'An error occurred: {}'.format(e)

    if errors and AskForRollback():
        print 'Rolling back...'
        # print 'See the end of the output for stack traces of the errors.'
        RollbackInstall(undoFunctions)
        # for error in errors:
        #     print error
        #     print


def AskForRollback():
    inp = ''
    while inp != 'y' and inp != 'n':
        inp = raw_input('Rollback? [y/n] ')
    return inp == 'y'

def ShouldIncludeFile(path, osNames, currentOs, ignore):
    """Returns whether the installer should include this file.
    When the file is either os specific for a different os, or
    it's in the ignore list, then it should not be included."""
    fileExt = FileExt(path.lower())
    return (not IsOsSpecificFileName(path, osNames) or fileExt == currentOs) and path not in ignore

def CreateLinkFunction(fromName, toName):
    """Creates a function that creates a symbolic link named 'toName', pointing to 'fromName'."""
    def linkFn():
        print 'Creating symlink: {} -> {}'.format(fromName, toName)
        os.symlink(fromName, toName)
    return linkFn

def CreateUndoFunction(toName):
    """Creates a function that removes a symbolic link named 'toName'."""
    def unlinkFn():
        print 'Removing symlink {}'.format(toName)
        os.unlink(toName)
    return unlinkFn

def RollbackInstall(functions):
    """Roll back the current installation. Taken is a list of functions to execute
    to perform the rollback. Errors are reported, but do not cancel the rollback,
    because we want to rollback as completely as possible."""
    for undoFn in functions:
        try:
            undoFn()
        except Exception as e:
            print 'Rollback failed: {}'.format(e)



###########################################################################
# Main (no shit)
###########################################################################
def Main():
    Install()

if __name__ == "__main__":
    Main()


