extends Node

var map : Array[Array] = []
var start_point_pos : Vector2


const DIRECTIONS :Array[Vector2i]= [Vector2i.UP, Vector2i.DOWN, Vector2i.RIGHT, Vector2i.LEFT]

func _init() -> void:
	_start_map()

func _start_map():
	map = []
	_init_map()
	_add_points()
	_create_map() #Randomized Depth-First Search

	print("Success in generating the map")
	print("TIME PASSED : " , float(Time.get_ticks_msec())/1000)

func _init_map():
	var map_size = SettingsData.map_size
	var chunk = []
	chunk.resize(map_size)
	for i in map_size:
		map.append(chunk.duplicate(true))

func _add_points():
	var map_size = SettingsData.map_size
	for y in range(map_size):
		for x in range(map_size):
			var point = Point.new(null)
			point.set_position(Vector2i(x,y))
			map[y][x] = point

func _create_map(): 
	#iniziando da un punto casuale della mappa, ci muoviamo a caso. Se nessun movimento è disponibile, backtracking (Randomized Depth-First Search)
	var pos :Vector2i= Vector2i(randi()%SettingsData.map_size,randi()%SettingsData.map_size)
	start_point_pos = pos
	var start_point :Point= _get_point(pos)
	start_point.set_start()

	var point :Point= null
	var previous_point :Point= start_point

	while point != start_point:

		var valid_directions :Array[Vector2i]= _valid_directions(pos)

		if len(valid_directions) > 0:
			var dir :Vector2i= valid_directions.pick_random()
			pos += dir
			point = _get_point(pos)
			point.set_parent(previous_point)
			previous_point = point
		
		else:
			previous_point = point.get_parent()
			point = point.get_parent()
			pos = point.get_position()
	
	#ora aggiungiamo le connessioni casuali

	for x in range(SettingsData.map_size):
		for y in range(SettingsData.map_size):
			pos = Vector2i(x,y)
			point = _get_point(pos)
			var valid_directions :Array[Vector2i]= _valid_directions_connections(pos)
			for direction in valid_directions:
				var roll = randf()
				if roll <= SettingsData.prob_connection:
					point.add_extra_connection(_get_point(pos+direction))

func _valid_directions(pos : Vector2i) -> Array[Vector2i]:
	var valid : Array[Vector2i] = []
	for direction in DIRECTIONS:
		if !_check_inside_map(pos + direction):
			continue
			
		var point : Point = _get_point(pos + direction)
		if point.get_parent() == null and point.is_start() == false:
			valid.append(direction)
		
	return valid

func _valid_directions_connections(pos : Vector2i) -> Array[Vector2i]:
	var start_point = _get_point(pos)
	var valid : Array[Vector2i] = []
	for direction in DIRECTIONS:
		if !_check_inside_map(pos + direction):
			continue
			
		var point : Point = _get_point(pos + direction)
		if point.get_parent() != start_point and start_point.get_parent() != point and not start_point in point.get_extra_connections() :
			valid.append(direction)
	
	return valid
	
func _check_inside_map(pos : Vector2i) -> bool:
	var map_size = SettingsData.map_size
	return (pos.y >= 0) and (pos.y < map_size) and (pos.x >= 0) and (pos.x < map_size)

func _get_point(position : Vector2i) -> Point:
	return map[position.y][position.x]


func get_map() -> Array[Array]:
	return map

func get_start_pos():
	return start_point_pos


class Point:
	var parent :Point = null
	var position : Vector2i = Vector2i.ZERO
	var extra_connections : Array[Point] = []
	var start : bool = false
	
	func _init(_parent : Point) -> void:
		self.parent = _parent

	func get_parent() -> Point:
		return self.parent
	
	func get_position() -> Vector2i:
		return self.position
	
	func get_extra_connections() -> Array[Point]:
		return self.extra_connections
	
	func is_start() -> bool:
		return self.start
	###############################
	func set_parent(_parent : Point) -> void:
		self.parent = _parent
	
	func set_position(_pos : Vector2i):
		self.position = _pos
	
	func add_extra_connection(point : Point):
		self.extra_connections.append(point)
	
	func set_start() -> void:
		self.start = true
