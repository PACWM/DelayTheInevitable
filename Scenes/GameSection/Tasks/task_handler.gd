class_name TaskHandler
extends Node

signal task_spawned

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
	task.removed.connect(task_removed)
	
	print("spawned task " , picked_task)
	tasks.append(task)
	emit_signal("task_spawned")
	
func task_removed(task : Task):
	tasks.erase(task)

func task_completed(task : Task):
	print("Completed task " , task)
	var time_extra = task.time_extra
	SignalBus.add_time.emit(time_extra)
