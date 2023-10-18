class_name Countdown
extends TimeCalculator


signal countdown_ended


func _ready() -> void:
	super.reset()
	print("preparo ", self.name)


## Get time elapsed taking pause time into account
func calc_time_elapsed() -> void:
	self.runTime = self.runStartTimestamp - self.currTime
	self.totalTime = self.runTime + self.pauseTime
	super.calc_time_elapsed()
	self.verify_end_of_countdown()


func initialize_end_time(time_elapsed) -> void:
	self.runStartTimestamp = self.currTime + time_elapsed + 1


func verify_end_of_countdown() -> void:
	if self.currStatus != GLOBALS.StatusType.RUNNING:
		return

	if self.totalTime <= 0:
		print("se a acabado el tiempo")
		self.countdown_ended.emit()
		self.reset()
