class_name Main
extends Node

const WINDOW = preload("uid://k402fmuxo8ne")

const TIMER = preload("uid://d1ey8rluly21m")
const GAME = preload("uid://djunwnbgi2ycl")

const TEST :WindowResource= preload("uid://c7uw5yhn6r1ck")

func _ready() -> void:
	summon_window(GAME.instantiate() , Vector2(500,500))
	summon_window(TIMER.instantiate() , Vector2(200,200))

func summon_window(node : Node, size : Vector2):
	var window :GameWindow= WINDOW.instantiate()
	window.window_data = TEST
	add_child(window)
