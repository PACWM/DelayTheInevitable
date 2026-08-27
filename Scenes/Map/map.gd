class_name Map
extends TileMapLayer

const Point = MapGenerator.Point

var map_generator :MapGenerator= MapGenerator.new()

@onready var map_size :int= SettingsData.map_size
@onready var map_scale :int= SettingsData.scale
@onready var map_border :int= SettingsData.border

func _ready() -> void:
	scale = Vector2(map_scale,map_scale)
	generate_background()
	generate_map()

func generate_background():
	for x in range(map_size * 2 - 1 + 2 * map_border):
		for y in range(map_size * 2 - 1 + 2 * map_border):
			var pos = Vector2(x,y)/2 - Vector2(map_border,map_border)/2
			place(pos,false)

func generate_map():
	var map :Array[Array]= map_generator.create_map()
	for y in range(map_size):
		for x in range(map_size):
			var pos :Vector2i= Vector2i(x,y)
			var point :Point = get_point(pos,map)
			place(pos,true)

			var parent : Point = point.get_parent()

			if parent != null:
				var parent_pos :Vector2i= parent.get_position()
				var delta :Vector2i = parent_pos - pos
				place(Vector2(pos) + Vector2(delta)/2, true)
			
			var extra_connections :Array[Point]= point.get_extra_connections()
			if len(extra_connections) > 0 :
				for extra_point in extra_connections:
					var extra_pos : Vector2i = extra_point.get_position()
					var extra_delta : Vector2i = extra_pos - pos
					place(Vector2(pos) + Vector2(extra_delta)/2,true)

func place(pos : Vector2, is_floor : bool ):
	set_cell(Vector2i(pos * 2) ,0, Vector2i(int(is_floor),0))


func get_point(pos : Vector2, map : Array[Array]) -> Point:
	return map[pos.y][pos.x]
