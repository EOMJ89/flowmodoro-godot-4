class_name TimeCalculator
extends Node
## Basic Logic for Timer / Countdown
##
## Initial logic for initialization, execution and switching modes for 
## Timer and Countdown Nodes.

## Status Enum for Current Status of the Node
var currStatus: GLOBALS.StatusType = GLOBALS.StatusType.NONE

## TimeStamp for
## the time at which a [color=yellow]Timer was started[/color] or
## the time at which a [color=yellow]Countdown will end[/color].
var runStartTimestamp: float = 0
## TimeStamp for the time at which a [color=yellow]Pause was started[/color].
var pauseStartTimestamp: float = 0

## Current time Elapsed in Timer / Remaining in Countdown.
var runTime: float = 0
## Current Pause time in Timer / Countdown.
var pauseTime: float = 0
## Current Total time Elapsed in Timer / Remaining in Countdown.
var totalTime: float = 0
## Shortcut to obtain current Unix Time From System.
var currTime: float:
	get:
		return Time.get_unix_time_from_system()

## Shortcut to convert a Unix Time Timestamp into
## a Time String Text for Visuals
var totalTimeText: String:
	get:
		return Time.get_time_string_from_unix_time(self.totalTime as int)


## Inicialization, reset the Node
func _ready() -> void:
	self.reset()


## Initialization of Status and Timestamps
func reset() -> void:
	self.runStartTimestamp = 0
	self.pauseStartTimestamp = 0

	self.runTime = 0
	self.pauseTime = 0
	self.totalTime = 0
	self.currStatus = GLOBALS.StatusType.NONE
	print("restart ", self.name)


## Process elapsed time when timer is running
func _process(_delta: float) -> void:
	if self.currStatus == GLOBALS.StatusType.RUNNING:
		self.calc_time_elapsed()


## Set mode to RUNNING for the first time
func start_run_mode() -> void:
	self.calc_time_elapsed()

	self.currStatus = GLOBALS.StatusType.RUNNING
	print("Inicia RUN MODE para ", self.name)


## Get elapsed time elapsed in inherited classes
func calc_time_elapsed() -> void:
	pass


## Set mode to PAUSE, save time at which Pause was started
func start_pause_mode() -> void:
	self.pauseStartTimestamp = self.currTime

	self.currStatus = GLOBALS.StatusType.PAUSED
	print("Inicia PAUSE MODE para ", self.name)


## Set mode to RUNNING after PAUSE and update the total paused time
func stop_pause_mode() -> void:
	self.pauseTime = self.refresh_time_paused()

	self.currStatus = GLOBALS.StatusType.RUNNING
	print("Termina PAUSE MODE para ", self.name)


## Calculates the total paused time 
func refresh_time_paused() -> float:
	var currTimePaused: float = self.currTime - self.pauseStartTimestamp
	return currTimePaused + self.pauseTime


## Switch mode to RUNNING or PAUSE according to the current mode
func switch_mode() -> void:
	match self.currStatus:
		GLOBALS.StatusType.NONE:
			self.start_run_mode()
		GLOBALS.StatusType.RUNNING:
			self.start_pause_mode()
		GLOBALS.StatusType.PAUSED:
			self.stop_pause_mode()
