class_name Countdown
extends TimeCalculator


func _ready() -> void:
	super.reset()
	print("preparo ", self.name)


## Get time elapsed
func calc_time_elapsed() -> void:
	self.runTime = self.runStartTimestamp - self.currTime
	self.totalTime = self.runTime + self.pauseTime
	super.calc_time_elapsed()

func initialize_end_time(time_elapsed) -> void:
	self.runStartTimestamp = self.currTime + time_elapsed + 1
