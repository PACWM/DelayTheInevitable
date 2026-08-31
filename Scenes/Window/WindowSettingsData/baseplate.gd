class_name WindowResource
extends Resource

@export_category("NodeData")
@export var node : PackedScene 
@export var node_window_size : Vector2

@export_category("WindowData")
@export var window_name : String
@export var window_size : Vector2 
@export_group("WindowRelativePosition")
@export_range(0,1,0.01) var x : float = 0 
@export_range(0,1,0.01) var y : float = 0 

@export_group("WindowProptieties" , "can_")
@export var can_close : bool = true
@export var can_minimize : bool = true
@export var can_move : bool = true
