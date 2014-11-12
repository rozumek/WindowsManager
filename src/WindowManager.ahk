/**
 * ======================================================
 * Windows manager
 * Version: 1.2.0 Alpha
 * Author: marcin.wyrozumski@esky.pl
 * ======================================================
 */

#SingleInstance force 			; file allowed to run only once
#NoEnv  						; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  							; Recommended for catching common errors.

SendMode Input  				; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  	; Ensures a consistent starting directory.

/**
 * ================================================================================
 * Including base libraries
 * ================================================================================
 */
#Include library\Rico.ahk
#Include library\KvalSky.ahk
#Include library\Private.ahk
#Include library\Skipper.ahk

/**
 * ================================================================================
 * Including application class
 * ================================================================================
 */
#Include src\Bootstrap.ahk

bootstrap := new Bootstrap()

/**
 * ================================================================================
 * Setting global data
 * ================================================================================
 */
#Include src\globals.ahk

/**
 * ========================================================r=======================
 * Loading plugins
 * ================================================================================
 */
modules := ["core", "browser_reloader", "app_goto", "cursor_manager", "calendar", "popup"]

loader := new Skipper.Loader()

if (loader.LoaderExists()) {
   #Include, *i autoload.tmp
} else {
    autoload := loader.LoadModules(modules)
    Rico.App.ReloadApp()
}
