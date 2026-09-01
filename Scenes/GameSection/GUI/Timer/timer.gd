extends Node2D

var time_remaining : float = -1

@onready var label: Label = $Bg/Label



func _process(_delta: float) -> void:
	time_remaining = GlobalVariables.time_remaining
	if time_remaining < 99.9:
		label.text = str(snappedf(time_remaining,0.1))
	else:
		label.text = "+99.9"
	var weight = clampf(time_remaining,0,15)/15
	var color : Color = lerp(Color.RED,Color.WHITE,weight)
	label.add_theme_color_override("font_color",color)

