class_name GameHandler
##L' handler del gioco, durante la partita, tutto verra' gestito da questo
extends Node2D

var timer_time_remaining : float = SettingsData.start_time_timer

@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var task_handler: TaskHandler = $TaskHandler ##TODO

@onready var event_timer: Timer = $EventTimer

##SORPRESA INFAME DA GODOT :P , non si possono vedere nell editor i callable.
##
## ATTENZIONE A NON SBORDARE DA 1 IN WEIGHT
var distribution : Dictionary[Callable,Dictionary] = {
	enemy_handler.spawn_enemy : {"weight" : 0.80 , "params" : [-1,10]},
	task_handler.spawn_task : {"weight" : 0.20 , "params" : [-1]}
}

func _ready() -> void:
	var events_distance = SettingsData.events_distance
	var delta = SettingsData.events_random_range
	event_timer.start(randf_range(events_distance-delta,events_distance+delta))
	SignalBus.add_time.connect(add_time)

func _process(delta: float) -> void:
	timer_time_remaining -= delta
	GlobalVariables.time_remaining = timer_time_remaining
	
	if timer_time_remaining <= 0:
		SignalBus.timeout.emit()

func _on_enemy_handler_player_killed(_enemy: Enemy) -> void:
	SignalBus.game_ended.emit()

func _on_event_timer_timeout() -> void:
	var events_distance = SettingsData.events_distance
	var delta = SettingsData.events_random_range
	event_timer.start(randf_range(events_distance-delta,events_distance+delta))
	#Per ora l' evento e' preso a random.
	var choice = randf()
	for i in distribution:
		var weight : float = distribution[i]["weight"]
		if weight > choice:
			i.call(distribution[i]["params"])
			break
		else:
			choice -= weight
	

func add_time(time : float):
	timer_time_remaining += time
