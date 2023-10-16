extends Node

@export var stopWatch: StopWatch
@export var countdown: Countdown

@export var timeLabel: Label


# Enum Vars
var currMode: GLOBALS.ModeType = GLOBALS.ModeType.NONE


func _ready() -> void:
	self._on_reset_button_pressed()


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
	self.stopWatch.reset()
	self.countdown.reset()
	self.currMode = GLOBALS.ModeType.NONE


func set_timer_text(text: String) -> void:
	self.timeLabel.text = text


func _on_break_work_button_pressed():
	match self.currMode:
		GLOBALS.ModeType.NONE:
			pass
		GLOBALS.ModeType.FOCUS:
			var time_elapsed: float = self.stopWatch.totalTime
			self.stopWatch.reset()
			self.countdown.reset()
			self.countdown.initialize_end_time(time_elapsed)
			self.countdown.switch_mode()
			self.currMode = GLOBALS.ModeType.BREAK
		GLOBALS.ModeType.BREAK:
			self.stopWatch.reset()
			self.countdown.reset()
			self.stopWatch.switch_mode()
			self.currMode = GLOBALS.ModeType.FOCUS
