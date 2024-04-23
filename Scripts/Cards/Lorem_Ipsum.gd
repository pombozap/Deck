extends Node

var data = {
	'Title': 'Lorem Ipsum',
	'Cost': '2',
	'Description': 'Lorem ipsum dolor sit amet.'

}
var card = get_parent()

func play():
	print_rich("Player played [b]", data['Title'], '[/b]!')

func _ready():
	card.load_data(data)
