class_name TimeCalculator
extends Node


# Status
var currStatus: GLOBALS.StatusType = GLOBALS.StatusType.NONE

# TimeStamps
var runStartTimestamp: float = 0
var pauseStartTimestamp: float = 0

# Times
var runTime: float = 0
var pauseTime: float = 0
var totalTime: float = 0
var currTime: float:
	get:
		return Time.get_unix_time_from_system()

# Text
var totalTimeText: String:
	get:
		return Time.get_time_string_from_unix_time(self.totalTime as int)


## Inicialization
func _ready() -> void:
	self.reset()


## Reset status and times
func reset() -> void:
	self.runStartTimestamp = 0
	self.pauseStartTimestamp = 0

	self.runTime = 0
	self.pauseTime = 0
	self.totalTime = 0
	self.currStatus = GLOBALS.StatusType.NONE
	print("restart ", self.name)


## Process elapsed time only when timer is running
func _process(_delta: float) -> void:
	if self.currStatus == GLOBALS.StatusType.RUNNING:
		self.calc_time_elapsed()


## Set mode to RUNNING for the first time
func start_run_mode() -> void:
	self.calc_time_elapsed()

	self.currStatus = GLOBALS.StatusType.RUNNING
	print("Inicia RUN MODE para ", self.name)


## Get time elapsed in inherited classes
func calc_time_elapsed() -> void:
	pass


## Set mode to PAUSE
func start_pause_mode() -> void:
	self.pauseStartTimestamp = self.currTime

	self.currStatus = GLOBALS.StatusType.PAUSED
	print("Inicia PAUSE MODE para ", self.name)


## Set mode to RUNNING after PAUSE
func stop_pause_mode() -> void:
	self.pauseTime = self.refresh_time_paused()

	self.currStatus = GLOBALS.StatusType.RUNNING
	print("Termina PAUSE MODE para ", self.name)


## Refresh pause time on unpause
func refresh_time_paused() -> float:
	# Get moment where the unpause button was pressed and calc pause time
	var currTimePaused: float = self.currTime - self.pauseStartTimestamp
	return currTimePaused + self.pauseTime


## Switch mode when pressing the button
func switch_mode() -> void:
	match self.currStatus:
		GLOBALS.StatusType.NONE:
			self.start_run_mode()
		GLOBALS.StatusType.RUNNING:
			self.start_pause_mode()
		GLOBALS.StatusType.PAUSED:
			self.stop_pause_mode()
