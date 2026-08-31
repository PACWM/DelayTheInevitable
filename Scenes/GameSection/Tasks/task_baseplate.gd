class_name Task
extends Node2D

@warning_ignore("unused_signal")
signal completed(Task)

signal removed(Task)

@export var time_extra : float = 00.0

func pick_position(map_size : int , graph_to_pos : Callable):
	var pos = Vector2(randi() % map_size , randi() % map_size) * 2
	global_position = graph_to_pos.call(pos)

func despawn():
	removed.emit(self)
	queue_free()
