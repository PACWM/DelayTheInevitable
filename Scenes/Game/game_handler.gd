class_name GameHandler
extends Node2D

signal start_game

@onready var enemy_handler: EnemyHandler = $EnemyHandler

func _ready() -> void:
		emit_signal("start_game")
		#Poi, con piu nemici, creerò anche un loop che spawna a intervalli irregolari, in posizioni a caso un nemico
		var id = enemy_handler.spawn_enemy(-1)
		await get_tree().create_timer(10).timeout
		
		#Questo verrà usato solo durante le task
		enemy_handler.freeze_enemies()
		await get_tree().create_timer(10).timeout
		
		#Stessa cosa, verrà usato durante le task
		enemy_handler.unfreeze_enemies()
		await get_tree().create_timer(10).timeout
		
		#Di nuovo, creeò un loop che gestisce spawn/despawn nemici
		#enemy_handler.despawn_enemy(id) Per ora lo commento pk nn voglio che durante il debug sto coso mi muore
		await get_tree().create_timer(10).timeout
