extends Node

var data = {
	'Title': 'Fireball',
	'Cost': '3',
	'Description': 'Enemies in a 20ft emanation take 6d8 fire damage.'

}
var card = get_parent()

func play():
	print_rich("Player played [b]", data['Title'], '[/b]!')

func _ready():
	card.load_data(data)
