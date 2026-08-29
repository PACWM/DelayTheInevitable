extends Node2D

var time_remaining : float = -1

@onready var label: Label = $Label

func _ready() -> void:
	SignalBus.time_remaining.connect(update_time_remaining)

func _process(_delta: float) -> void:
	label.text = str(snappedf(time_remaining,0.1))
	var weight = clampf(time_remaining,0,15)/15
	var color : Color = lerp(Color.RED,Color.WHITE,weight)
	label.add_theme_color_override("font_color",color)

func update_time_remaining(time:float):
	time_remaining = time
