extends Node2D
@export var card_data: Script
@export var pixel_size: int = 5
@export var functionality_script: Script

func is_hovered ():
	var rect: Rect2 = Rect2(Vector2(-125, -175), Vector2(125, 175))
	return rect.has_point(get_local_mouse_position())

func assign (title: String):
	$Functionality.set_script(load("res://Scripts/Cards/" + title + ".gd"))

func play ():
	$Functionality.play()

func get_cost () -> int:
	return int($Functionality.data['Cost'])

func get_title () -> String:
	return $Functionality.data['Title']
	
func get_rect () -> Rect2:
	return $Area2D/Hitbox.shape.rect
	
func load_data (data: Dictionary):
	$Control/TitleContainer/Title.text = data['Title']
	$Control/DescriptionContainer/Description.text = data['Description']
	$Control/CostContainer/Cost.text = ' ' + str(data['Cost']) + ' '
	var image_path = "res://Data/Textures/Cards/" + data['Title'] + '.png'
	$Control/ImageContainer/Image.texture = load(image_path)

func _ready():
	#pivot_offset = $Area2D/Hitbox.shape.size * scale.x
	pass

func _on_mouse_entered():
	get_parent()._on_card_mouse_entered(self)
	
	
func _on_mouse_exited():
	get_parent()._on_card_mouse_exited(self)
