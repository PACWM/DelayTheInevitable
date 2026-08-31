class_name GameHandler
##L' handler del gioco, durante la partita, tutto verra' gestito da questo
extends Node2D

var timer_time_remaining : float = SettingsData.start_time_timer

@onready var enemy_handler: EnemyHandler = $EnemyHandler

@onready var event_timer: Timer = $EventTimer

func _ready() -> void:
	event_timer.start(1)

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
	#Per ora un evento e' solo lo spawn di un nemico
	enemy_handler.spawn_enemy(-1,5.0) #spawno per debug il nemico di debug per 5 sec.
