class_name GameHandler
##L' handler del gioco, durante la partita, tutto verra' gestito da questo
extends Node2D

var timer_time_remaining : float = SettingsData.start_time_timer

@onready var enemy_handler: EnemyHandler = $EnemyHandler
@onready var task_handler: TaskHandler = $TaskHandler ##TODO

@onready var event_timer: Timer = $EventTimer

func _ready() -> void:
	event_timer.start(1)
	SignalBus.add_time.connect(add_time)

func _process(delta: float) -> void:
	timer_time_remaining -= delta
	SignalBus.time_remaining.emit(timer_time_remaining)
	
	if timer_time_remaining <= 0:
		SignalBus.timeout.emit()

func _on_enemy_handler_player_killed(_enemy: Enemy) -> void:
	SignalBus.game_ended.emit()

func _on_event_timer_timeout() -> void:
	var events_distance = SettingsData.events_distance
	var delta = SettingsData.events_random_range
	event_timer.start(randi_range(events_distance-delta,events_distance+delta))
	#Per ora l' evento e' preso a random.
	var choices = 2
	var choice = randi() % choices
	match choice:
		0:
			enemy_handler.spawn_enemy(-1,11.0) #spawno per debug il nemico di debug per 11 sec.
		1:
			task_handler.spawn_task(-1)

func add_time(time : float):
	timer_time_remaining += time
