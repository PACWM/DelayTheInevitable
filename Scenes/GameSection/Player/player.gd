class_name Player
extends CharacterBody2D

@onready var map : Map = $"../Map"

##TODO : RENDERE IL MOVIMENTO PIU DINAMICO

func _ready() -> void:
	position = _pick_position()

func _physics_process(delta: float) -> void:
	GlobalVariables.player_position = position
	var direction = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	
	if direction != Vector2.ZERO:
		velocity = lerp(velocity ,
		direction * SettingsData.player_speed ,
		clampf(SettingsData.player_accel * delta,0.0,1.0)
		)
		
	else:
		velocity = lerp(velocity ,
		Vector2.ZERO ,
		clampf(SettingsData.player_decel * delta, 0.0,1.0)
		)
	
	var collision : KinematicCollision2D = move_and_collide(velocity * delta)
	if collision == null:
		return
	
	#LA NORMALE è UN VETTORE PERPENDICOLARE ALLA COLLISIONE VERSO L' ESTERNO RISPETTO AL [CharterBody2D]
	var collision_dir = collision.get_normal()
	
	var bounce_multiplyer = -collision_dir.abs() * SettingsData.bounce_deficit
	
	var result = Vector2(
		1.0 if bounce_multiplyer.x == 0 else bounce_multiplyer.x,
		1.0 if bounce_multiplyer.y == 0 else bounce_multiplyer.y
	)
	velocity *= result
	
func _pick_position()-> Vector2:
	var graph_pos = MapGenerator.get_start_pos()
	var map_pos = map.graph_to_map(graph_pos)
	print("map_pos = " , map_pos)

	return map_pos
