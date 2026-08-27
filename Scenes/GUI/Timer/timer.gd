extends Node2D

signal timeout

var time_remaining : float = 15

@onready var label: Label = $Label

func _process(delta: float) -> void:
	if time_remaining > 0:
		time_remaining -= delta
		
	else:
		emit_signal("timeout")
		time_remaining = 0
		
	label.text = str(snappedf(time_remaining,0.1))
	var weight = clampf(time_remaining,0,15)/15
	var color : Color = lerp(Color.RED,Color.WHITE,weight)
	label.add_theme_color_override("font_color",color)

func add_time(time : float) -> void:
	time_remaining += time
