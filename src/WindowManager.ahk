﻿/**
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

/**
 * ================================================================================
 * Including application class
 * ================================================================================
 */
#Include src\Application.ahk

application := new Application()
application
	.Bootstrap()
	.Run()

/**
 * ================================================================================
 * Setting global data
 * ================================================================================
 */
global config := application.config
global wiki := application.wiki
global version := application.version

global browsers := KvalSky.Enum.Browsers
global programs := KvalSky.Enum.Programs

/**
 * ========================================================r=======================
 * Loading plugins
 * ================================================================================
 */

modules := ["core","browser_reloader","app_goto","cursor_manager","calendar","popup"]

;for index, module in modules 
;{
;	modulePath := "#Include asrc\" . module . "\module.ahk `n"
;	FileAppend, %modulePath%, TemporaryFile.txt
;}

;#Include, *i TemporaryFile.txt
;FileDelete TemporaryFile.txt

#Include src\plugins\core\module.ahk
#Include src\plugins\app_goto\module.ahk
#Include src\plugins\browser_reloader\module.ahk
#Include src\plugins\cursor_manager\module.ahk
#Include src\plugins\popup\module.ahk
#Include src\plugins\calendar\module.ahk

 


