class_name Main
extends Node

const WINDOW = preload("uid://k402fmuxo8ne")

const GAME :WindowResource= preload("res://Scenes/GUI/Window/WindowSettingsData/game.tres")
const TIMER = preload("uid://b1q7pkgd4n0u6")

var nodes_to_eliminate : Array[GameWindow]

func _ready() -> void:
	SignalBus.game_started.connect(_start_game)
	SignalBus.game_ended.connect(_end_game)
	
	SignalBus.game_started.emit()

func _start_game():
	_clear()
	var game_window :GameWindow= WINDOW.instantiate()
	game_window.window_data = GAME
	add_child(game_window)
	
	var timer_window : GameWindow = WINDOW.instantiate()
	timer_window.window_data = TIMER
	add_child(timer_window)
	
	nodes_to_eliminate += [game_window,timer_window]

func _end_game():
	_clear()
	

func _clear():
	for i in nodes_to_eliminate:
		i.close()
	
	nodes_to_eliminate = []
	
