extends Node

@export var stopWatch: StopWatch
@export var countdown: Countdown

@export var timeLabel: Label


## Enum Vars
var currMode: GLOBALS.ModeType = GLOBALS.ModeType.NONE


func _ready() -> void:
	self.reset_main_component()


## Reset button
func _on_reset_button_pressed() -> void:
	self.reset_main_component()


## Reset entire component
func reset_main_component() -> void:
	self.reset_both_timers()
	self.currMode = GLOBALS.ModeType.NONE


## Reset timer
func reset_both_timers() -> void:
	self.stopWatch.reset()
	self.countdown.reset()


func _process(_delta: float) -> void:
	match self.currMode:
		GLOBALS.ModeType.NONE:
			self.set_timer_text("00:00:00")
		GLOBALS.ModeType.FOCUS:
			self.set_timer_text(self.stopWatch.totalTimeText)
		GLOBALS.ModeType.BREAK:
			self.set_timer_text(self.countdown.totalTimeText)


## Update visual clock
func set_timer_text(text: String) -> void:
	self.timeLabel.text = text


## Switch modes
func _on_break_work_button_pressed() -> void:
	match self.currMode:
		GLOBALS.ModeType.NONE:
			# Does nothing, there's no active mode
			pass
		GLOBALS.ModeType.FOCUS:
			# Calculates BREAK time and starts BREAK mode
			var time_elapsed: float = self.stopWatch.totalTime
			self.reset_both_timers()
			self.countdown.initialize_end_time(time_elapsed)
			self.countdown.switch_mode()
			self.currMode = GLOBALS.ModeType.BREAK
		GLOBALS.ModeType.BREAK:
			# Starts FOCUS Mode
			self.reset_both_timers()
			self.stopWatch.switch_mode()
			self.currMode = GLOBALS.ModeType.FOCUS


## Pause / Unpause running mode
func _on_start_pause_button_toggled(_button_pressed: bool) -> void:
	match self.currMode:
		GLOBALS.ModeType.NONE:
			# Automatically starts FOCUS mode
			self.countdown.reset()
			self.stopWatch.switch_mode()
			self.currMode = GLOBALS.ModeType.FOCUS
		GLOBALS.ModeType.FOCUS:
			# Pauses/Unpauses FOCUS mode
			self.stopWatch.switch_mode()
		GLOBALS.ModeType.BREAK:
			# Pauses/Unpauses BREAK mode
			self.countdown.switch_mode()


## Signal Reaction
func _on_countdown_countdown_ended():
	self.reset_main_component()
