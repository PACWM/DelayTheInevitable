extends Node

#Map settings
@export_category("Map")
@export var map_size : int = 5
@export_range(0.0,1.0,0.01) var prob_connection : float = 0.15 #Value from 0 to 1
## The default scale is 12
@export var scale : int = 12
@export var border : int = 1

#Player settings
@export_category("Player")
@export var player_speed : int = 1000
@export var player_accel : float = 1
@export var player_decel : float = 0.5
##[param velocity] * [param bounce_deficit] in the collided direction
@export_range(0.0,1.0,0.01) var bounce_deficit : float = 0.25

#Timer settings
@export_category("Timer")
@export var start_time_timer : float = 60.0
@export var increase_time_for_action : Dictionary[String,float] = {
}
