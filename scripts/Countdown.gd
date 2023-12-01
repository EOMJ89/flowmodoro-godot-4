class_name Countdown
extends TimeCalculator


signal countdown_ended


@export_range(3, 5, 1.0) var time_divisor: float = 3


func _ready() -> void:
	super.reset()
	print("preparo ", self.name)


## Get time elapsed taking pause time into account
func calc_time_elapsed() -> void:
	self.runTime = self.runStartTimestamp - self.currTime
	self.totalTime = self.runTime + self.pauseTime
	super.calc_time_elapsed()
	self.verify_end_of_countdown()

## Set countdown time + an extra second to prevent instant second switching
func initialize_end_time(time_elapsed: float) -> void:
	var future_time: float = time_elapsed / self.time_divisor
	self.runStartTimestamp = floori(self.currTime + future_time) + 0.999

## Verify if the countdown ended and send the signal if the countdown ended
func verify_end_of_countdown() -> void:
	if self.currStatus != GLOBALS.StatusType.RUNNING:
		return
	
	if self.totalTime <= 0:
		self.countdown_ended.emit()
		self.reset()
