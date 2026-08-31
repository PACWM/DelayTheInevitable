class_name Enemy
extends Node

signal dead_player(Enemy)

var ID : int = -1
var player : CharacterBody2D = null

func setup(_ID : int , _player : CharacterBody2D) -> void:
	ID = _ID
	player = _player
	

func _enter_tree() -> void:
	if ID == -1:
		printerr("NESSUN ID ASSEGNATO A " , self)


@warning_ignore("unused_parameter")
func spawn(target_ID : int):
	if target_ID != ID:
		return
	
	on_spawn()

@warning_ignore("unused_parameter")
func despawn(target_ID : int):
	if target_ID != ID:
		return
	
	on_despawn()



func on_spawn():
	pass

func on_despawn():
	pass

## Used to freeze all enemies
func freeze():
	pass

## Used to make all enemies keep going
func unfreeze():
	pass

## Used when the player fails
func call_dead():
	emit_signal("dead_player",self)
