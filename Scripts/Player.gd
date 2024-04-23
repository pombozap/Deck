extends CharacterBody2D

func set_outline (status: bool):
	$OutlineComponent.set_outline(status)

func _ready():
	$Sprite.play()
