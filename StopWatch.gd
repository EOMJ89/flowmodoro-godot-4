class_name StopWatch
extends TimeCalculator


func _ready() -> void:
	super.reset()
	print("preparo ", self.name)


## Get time elapsed
func calc_time_elapsed() -> void:
	self.runTime = self.currTime - self.runStartTimestamp
	self.totalTime = self.runTime - self.pauseTime
	super.calc_time_elapsed()


## Set mode to RUNNING for the first time
func start_run_mode() -> void:
	self.runStartTimestamp = self.currTime
	super.start_run_mode()
