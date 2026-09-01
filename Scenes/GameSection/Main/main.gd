class_name Main
extends Node

const WINDOW = preload("uid://k402fmuxo8ne")

var nodes_to_eliminate : Array[GameWindow]

@export var game_start_windows : Array[WindowResource]

func _ready() -> void:
	SignalBus.game_started.connect(_start_game)
	SignalBus.game_ended.connect(_end_game)
	
	SignalBus.game_started.emit()

func _start_game():
	_clear()
	for i in game_start_windows:
		var window :GameWindow= WINDOW.instantiate()
		window.window_data = i
		add_child(window)
		nodes_to_eliminate.append(window)

func _end_game():
	_clear()
	

func _clear():
	for i in nodes_to_eliminate:
		i.close()
	
	nodes_to_eliminate = []
	
