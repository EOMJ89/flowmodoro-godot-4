extends Node

@export var stopWatch: StopWatch
@export var countdown: Countdown

@export var timeLabel: Label


# Enum Vars
var currMode: GLOBALS.ModeType = GLOBALS.ModeType.NONE


func _ready() -> void:
	self.reset_main_component()


func _process(_delta: float) -> void:
	match self.currMode:
		GLOBALS.ModeType.NONE:
			self.set_timer_text("__:__:__")
		GLOBALS.ModeType.FOCUS:
			self.set_timer_text(self.stopWatch.totalTimeText)
		GLOBALS.ModeType.BREAK:
			self.set_timer_text(self.countdown.totalTimeText)


func _on_start_pause_button_toggled(_button_pressed: bool) -> void:
	match self.currMode:
		GLOBALS.ModeType.NONE: # automatically starts focus mode
			self.countdown.reset()
			self.stopWatch.switch_mode()
			self.currMode = GLOBALS.ModeType.FOCUS
		GLOBALS.ModeType.FOCUS: # pauses/unpauses focus mode
			self.stopWatch.switch_mode()
		GLOBALS.ModeType.BREAK: # pauses/unpauses break mode
			self.countdown.switch_mode()


func _on_reset_button_pressed() -> void:
	self.reset_main_component()


func reset_main_component() -> void:
	self.reset_both_timers()
	self.currMode = GLOBALS.ModeType.NONE


func reset_both_timers() -> void:
	self.stopWatch.reset()
	self.countdown.reset()


func set_timer_text(text: String) -> void:
	self.timeLabel.text = text


func _on_break_work_button_pressed() -> void:
	match self.currMode:
		GLOBALS.ModeType.NONE:
			pass
		GLOBALS.ModeType.FOCUS:
			var time_elapsed: float = self.stopWatch.totalTime
			self.reset_both_timers()
			self.countdown.initialize_end_time(time_elapsed)
			self.countdown.switch_mode()
			self.currMode = GLOBALS.ModeType.BREAK
		GLOBALS.ModeType.BREAK:
			self.reset_both_timers()
			self.stopWatch.switch_mode()
			self.currMode = GLOBALS.ModeType.FOCUS


func _on_countdown_countdown_ended():
	self.reset_main_component()
