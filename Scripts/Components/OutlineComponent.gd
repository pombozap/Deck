extends Node

@onready var shader_material: ShaderMaterial = ShaderMaterial.new()
@onready var shader: Shader = preload("res://Scripts/Shaders/Outline.gdshader")
@export var sprite: CanvasItem

func set_outline (status: bool):
	if sprite == null:
		return
		
	print('Outline set to ', status)
	if status:
		sprite.material = shader_material
	else:
		sprite.material = null

func _ready():
	if sprite != null:
		shader_material.shader = shader
		sprite.material = shader_material
		set_outline(false)

