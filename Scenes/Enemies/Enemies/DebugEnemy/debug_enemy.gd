class_name DebugEnemy
extends Enemy

@onready var navigation_agent_2d: NavigationAgent2D =$DebugEnemy/NavigationAgent2D 
@onready var body: CharacterBody2D = $DebugEnemy

var stopped : bool = false

func on_spawn():
	print("HELOOOOOOOOO; I'm ALIVE :) ")
	print("I'M A CHASE YOU BISH")

func on_despawn():
	print("OOF :(")
	queue_free()

func freeze():
	stopped = true
	print("STOP O.O")

func unfreeze():
	stopped = false
	print("UNSTOP owo")
	

func _process(delta: float) -> void:
	if stopped == true:
		return
	navigation_agent_2d.target_position = player.position
	body.position = lerp(body.position , navigation_agent_2d.get_next_path_position(),5 * delta)
	


func _on_area_2d_body_entered(_body: Node2D) -> void:
	if stopped == true or not (_body is Player):
		return
	print("YOU ARE DEAD UwU")
	dead_player.emit(self)
