class_name TimerHandler
extends Node



var timer_time_remaining : float = SettingsData.start_time_timer

func _process(delta: float) -> void:
	timer_time_remaining -= delta
	SignalBus.time_remaining.emit(timer_time_remaining)
	
	if timer_time_remaining <= 0:
		SignalBus.timeout.emit()
