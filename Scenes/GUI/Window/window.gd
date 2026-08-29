class_name GameWindow
extends Control

var mouse_upper_bar : bool = false
var delta_pos : Vector2 = Vector2.ZERO

@export var window_data : WindowResource


@onready var sub_viewport: SubViewport = $Viewport/SubViewport
@onready var upper_bar: ColorRect = $UpperBar
@onready var window_name: Label = $UpperBar/HBoxContainer/WindowName

func _ready() -> void:
	if window_data == null:
		printerr("DATA NOT AVAILABLE FOR WINDOW!")
		queue_free()
		return
	sub_viewport.add_child(window_data.node.instantiate())
	sub_viewport.size = window_data.node_window_size
	size = window_data.window_size
	window_name.text = window_data.window_name
	global_position = Vector2(window_data.x,window_data.y) * (get_viewport().get_visible_rect().size - upper_bar.size)
	

func _process(_delta: float) -> void:
	if mouse_upper_bar and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and window_data.can_move:
		delta_pos = get_global_mouse_position() - global_position
		while Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			var wanted_pos :Vector2= get_global_mouse_position() - delta_pos
			global_position = wanted_pos.clamp(Vector2(0,0),get_viewport().get_visible_rect().size - upper_bar.size)
			await get_tree().process_frame

func _on_upper_bar_mouse_entered() -> void:
	mouse_upper_bar = true

func _on_upper_bar_mouse_exited() -> void:
	mouse_upper_bar = false
