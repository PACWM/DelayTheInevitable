class_name DebugMap
extends Node2D

signal ended_generation

var map_generator = MapGenerator.new()
var map : Array[Array] = []

@onready var tile_map: TileMapLayer = $TileMapLayer


func _ready() -> void:

	map = map_generator.create_map()
	
	
	for y in map:
		for point:RefCounted in y:

			var parent :RefCounted= point.get_parent()
			var point_position :Vector2i= Vector2i(point.get_position()) * 2
			if parent == null:
				var _point_position :Vector2i= Vector2i(point.get_position()) * 2
				tile_map.set_cell(_point_position,1,Vector2i.ZERO)
			
			else:
				tile_map.set_cell(point_position,0,Vector2i.ZERO)
				var parent_position :Vector2i= Vector2i(parent.get_position()) * 2
				@warning_ignore("integer_division")
				var delta :Vector2i= (parent_position-point_position)/2 
				var path_position : Vector2i = delta + point_position
				tile_map.set_cell(path_position,0,delta + Vector2i.ONE)
				
			var connections = point.get_extra_connections()
			for target in connections:
				var target_position :Vector2i= Vector2i(target.get_position()) * 2
				@warning_ignore("integer_division")
				var target_delta :Vector2i= (target_position-point_position)/2 
				var path_pos : Vector2i = target_delta + point_position
				tile_map.set_cell(path_pos,1,target_delta + Vector2i.ONE)
	
	await get_tree().physics_frame
	emit_signal("ended_generation")

''' CLASS POINT FUNCTIONS AND PROPRIETIES
class Point:
	var parent :Point = null
	var ID : int = -1
	var position : Vector2i = Vector2i.ZERO
	var root : bool = false
	var extra_connections : Array[Point] = []
	
	func _init(_parent : Point, id) -> void:
		self.parent = _parent
		self.ID = id
	
	func get_parent() -> Point:
		return self.parent
	
	func get_position() -> Vector2i:
		return self.position
	
	func get_id() -> int:
		return self.ID
	
	func get_root() -> bool:
		return self.root
	
	func get_extra_connections() -> Array[Point]:
		return self.extra_connections
	###############################
	func set_parent(_parent : Point) -> void:
		self.parent = _parent
	
	func set_position(_pos : Vector2i):
		self.position = _pos
	
	func set_id(value : int):
		self.ID = value
	
	func set_root():
		self.root = true
	
	func add_extra_connection(point : Point):
		extra_connections.append(point)
'''

func get_cell_data(pos : Vector2i):
	return tile_map.get_cell_tile_data(pos)
