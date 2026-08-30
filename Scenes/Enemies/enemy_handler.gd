class_name EnemyHandler
extends Node

signal spawn(int)
signal despawn(int)
signal freeze
signal unfreeze

signal player_killed(Enemy)

const ENEMIES_LIST :Dictionary[int,PackedScene]= {
	-1 : preload("res://Scenes/Enemies/Enemies/DebugEnemy/debug_enemy.tscn"),
}

## ENEMY -> ID
var enemies_in_game : Dictionary[int,Enemy] = {}

var last_id_used : int = -1

@onready var player: CharacterBody2D = $"../Player"

## Picked enemy is taken from the [param ENEMIES_LIST]
func spawn_enemy(picked_enemy : int = -1 , time_in_game : float = 0.0) -> int:
	var enemy :Enemy= ENEMIES_LIST[picked_enemy].instantiate()
	last_id_used += 1
	enemy.setup(last_id_used , player)
	_connect_signals(enemy)
	add_child(enemy)
	emit_signal("spawn" , last_id_used)
	enemies_in_game[last_id_used] = enemy
	
	if time_in_game != 0.0:
		var timer :Timer= Timer.new()
		timer.one_shot = true
		timer.autostart = true
		timer.wait_time = time_in_game
		timer.timeout.connect(func(): despawn.emit(last_id_used) ; print("eliminato id " , last_id_used))
		enemy.add_child(timer)
	
	return last_id_used

func _connect_signals(enemy : Enemy):
	spawn.connect(enemy.spawn)
	despawn.connect(enemy.despawn)
	freeze.connect(enemy.freeze)
	unfreeze.connect(enemy.unfreeze)
	enemy.dead_player.connect(on_player_dead_signal)
	

func despawn_enemy(enemy_id : int):
	emit_signal("despawn",enemy_id)
	var error = enemies_in_game.erase(enemy_id)
	if error:
		return
	printerr("Tried to eliminate unexistent ID : " , enemy_id)

func freeze_enemies():
	emit_signal("freeze")

func unfreeze_enemies():
	emit_signal("unfreeze")

func on_player_dead_signal(enemy:Enemy):
	player_killed.emit(enemy)
