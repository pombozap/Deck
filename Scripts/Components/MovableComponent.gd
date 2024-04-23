extends Node

@export var arena: TileMap
@export var audio_suite: AudioStreamPlayer2D
@export var move_dist: int = 5

@onready var entity: Node = get_parent()
@onready var last_tile: Vector2i = Vector2i.ZERO
@onready var arena_size: Vector2i = arena.get_size()
@onready var selection: Node2D = null
@onready var move_path: Array[Vector2i] = []

func _ready():
	pass

func _process(delta):
	var mouse_position: Vector2i = arena.local_to_map(arena.get_global_mouse_position())
	var player_position: Vector2i = arena.local_to_map(entity.global_position)

	if Input.is_action_just_pressed("click"):
		if player_position == mouse_position:
			selection = entity
			entity.set_outline(true)
			audio_suite.select()

	if Input.is_action_just_released("click"):
		entity.set_outline(false)
		if arena.is_out_of_bounds(mouse_position):
			#audio_suite.forbidden()
			pass

		elif len(move_path) == 0:
			audio_suite.forbidden()

		elif selection != null:
			selection.global_position = arena.map_to_local(move_path[-1])
			selection = null
			audio_suite.drop()

	if not arena.is_out_of_bounds(mouse_position):
		if mouse_position != last_tile:
			last_tile = mouse_position
			arena.clear_selection()
			#audio_suite.hover()

			if Input.is_action_pressed("click"):
				var path: Array[Vector2i] = arena.find_path(player_position, mouse_position)
				if len(path) > move_dist:
					path = path.slice(0, move_dist)

				move_path = path
				for tile in path:
					arena.select(tile)

			else:
				arena.select(mouse_position)

	else:
		arena.clear_layer(1)
