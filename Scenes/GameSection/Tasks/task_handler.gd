class_name TaskHandler
extends Node


const TASKS : Dictionary[int,PackedScene] = {
	-1 : preload("uid://umxitohg3t35")
}

var tasks : Array[Task] = []

@onready var map: Map = $"../Map"

func _ready() -> void:
	spawn_task()


func spawn_task(picked_task : int = -1):
	var task :Task= TASKS[picked_task].instantiate()
	add_child(task)
	task.pick_position(SettingsData.map_size , map.graph_to_map)
	task.completed.connect(task_completed)
	task.removed.connect(_task_removed)
	
	print("spawned task " , picked_task)
	tasks.append(task)
	SignalBus.task_spawned.emit(tasks)
	
func _task_removed(task : Task):
	tasks.erase(task)
	SignalBus.task_removed.emit(tasks)

func task_completed(task : Task):
	print("Completed task " , task)
	var time_extra = task.time_extra
	SignalBus.add_time.emit(time_extra)
