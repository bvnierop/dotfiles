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
OsNames = CreateEnum(LINUX='linux', WINDOWS='windows')

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

def ScriptDir():
    return os.path.dirname(os.path.abspath(__file__))

def ListFiles(path):
    try:
        return os.listdir(path)
    except OSError as error:
        raise IOError(*error.args)

def IsOsSpecificFileName(fileName, osNames):
    lowercaseOsNames = [name.lower() for name in osNames]
    fileExt = FileExt(fileName.lower())
    return fileExt in lowercaseOsNames

def FileExt(path):
    _, fileExt = os.path.splitext(path)
    if fileExt.startswith('.'):
        fileExt = fileExt[1:]
    return fileExt

def ShouldIncludeFile(path, osNames, currentOs, ignore):
    fileExt = FileExt(path.lower())
    return (not IsOsSpecificFileName(path, osNames) or fileExt == currentOs) and path not in ignore

def CreateLinkFunction(fromName, toName):
    def linkFn():
        print 'Creating symlink: {} -> {}'.format(fromName, toName)
        os.symlink(fromName, toName)
    return linkFn

def CreateUndoFunction(toName):
    def unlinkFn():
        print 'Removing symlink {}'.format(toName)
        os.unlink(toName)
    return unlinkFn

def ScriptDirPath(name):
    return os.path.join(ScriptDir(), name)

def HomeDirPath(name, osNames, currentOs):
    if (IsOsSpecificFileName(name, osNames)):
        name = ''.join(name.rsplit('.' + currentOs, 1))
    return os.path.join(os.path.expanduser('~'), name)

def Install():
    osNames = [OsNames.LINUX, OsNames.WINDOWS]
    currentOs = platform.system().lower()
    names = ListFiles(ScriptDir())
    filteredNames = [name for name in names if ShouldIncludeFile(name, osNames, currentOs, Ignore)]

    functions = [(CreateLinkFunction(ScriptDirPath(name), HomeDirPath(name, osNames, currentOs)),
        CreateUndoFunction(HomeDirPath(name, osNames, currentOs))) for name in filteredNames]

    undoFunctions = []

    for perform, undo in functions:
        try:
            perform()
            undoFunctions.append(undo)
        except Exception as e:
            import traceback
            print 'An error occurred: {}'.format(e)
            print 'See the end of the output for the stack trace.'
            print 'Rolling back...'
            rollback(undoFunctions)
            raise

def rollback(functions):
    for undoFn in functions:
        try:
            undoFn()
        except:
            print 'Rollback failed'

def Main():
    Install()

if __name__ == "__main__":
    Main()


