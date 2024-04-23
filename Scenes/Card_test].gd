extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mouse_entered():
	print('enter')


func _on_mouse_exited():
	print('exit')
	pass # Replace with function body.


func _on_background_mouse_entered():
	print('enter bg')


func _on_background_mouse_exited():
	print('exit bg')
