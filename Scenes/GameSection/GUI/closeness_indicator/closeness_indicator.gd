extends Node2D

@onready var closeness_image: ColorRect = $ClosenessImage

var tasks : Array[Task]

func _ready() -> void:
	closeness_image.material.set_shader_parameter("fill" , 0)
	SignalBus.task_removed.connect(update_tasks)
	SignalBus.task_spawned.connect(update_tasks)

func _process(_delta: float) -> void:
	if len(tasks) == 0:
		closeness_image.material.set_shader_parameter("fill" , 0)
		return
	
	var player_pos = GlobalVariables.player_position
	
	var minor_delta : float = INF
	for task in tasks:
		var delta = player_pos.distance_to(task.position) #Task eredita da Node2D, quindi 0 problemi :P
		if delta < minor_delta:
			minor_delta = delta
	
	
	var fill = abs(clampf(minor_delta,0,4000)/4000 - 1)
	closeness_image.material.set_shader_parameter("fill" , fill)
	print("Fill : " , fill , " Delta : " , minor_delta)



func update_tasks(new_tasks : Array[Task]):
	tasks = new_tasks
