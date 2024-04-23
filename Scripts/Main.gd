extends Node2D

@onready var arena: TileMap = $Arena
@onready var player: CharacterBody2D = $Player

@onready var card = preload("res://Scenes/Card.tscn")
@onready var card_test = preload("res://Scenes/Card_test].tscn")
var current_card = null
var current_deck: Array = []
var active_card = null

@onready var deck_center: Vector2 = $Deck.global_position
@onready var deck_span: float = $Deck/DeckSpace.shape.size.x
@onready var deck_half_span: float = $Deck/DeckSpace.shape.size.x / 2 - 30
@onready var deck_rect: Rect2 = Rect2(deck_center - $Deck/DeckSpace.shape.size / 2, $Deck/DeckSpace.shape.size)

var is_mouse_on_deck: bool = false
	
	
func print_variables ():
	print('is_mouse_on_deck: ', is_mouse_on_deck)

func update_card_positions ():
	var deck_size: int = len(current_deck)
	
	if deck_size == 0:
		return
		
	if deck_size == 1:
		current_deck[0].global_position = deck_center
		return
		
	var deck_start = deck_center.x - deck_half_span
	var deck_end = deck_center.x + deck_half_span
	
	for i in range(deck_size):
		current_deck[i].global_position.x = lerp(deck_start, deck_end, i/float(deck_size -1))

func draw_card(card_name: String):
	var card_instance = card.instantiate()
	card_instance.visible = false
	card_instance.global_position = deck_center - 2 * Vector2(deck_half_span, 0)
	card_instance.assign(card_name)
	card_instance.set_scale(Vector2.ONE * 0.25)
	current_deck.append(card_instance)
	update_card_positions()
	card_instance.visible = true
	add_child(card_instance)
	$AudioPlayer/CardDraw.play()
	
func draw_card_test():
	var instance = card_test.instantiate()
	instance.global_position = get_global_mouse_position()
	add_child(instance)
	print('called')
	
func read_title(card: Node) -> String:
	if card == null:
		return '[]'
	else:
		return card.get_title()

func _ready():
	player.position = arena.map_to_local(Vector2i(0, 8))
	
	
func _process(delta):
	var mouse_position: Vector2 = get_global_mouse_position()
		
	update_card_positions()
	
	if len(current_deck) > 0:
		for card in current_deck:
			card.position.y = deck_center.y
	
	#print(active_card)
	if current_card != null:
		current_card.position.y = deck_center.y - 20
		
	var hovering = null
		
	if is_mouse_on_deck and len(current_deck) > 0:
		var selected_card: int = floor(float(len(current_deck) + 1) * (mouse_position.x - deck_center.x + deck_span / 2) / deck_span)
		if selected_card >= len(current_deck):
			selected_card = len(current_deck) - 1
		
		current_deck[selected_card].position.y = deck_center.y - 20
		
		if Input.is_action_just_pressed("click"):
			var card = current_deck[selected_card]
			current_deck.remove_at(selected_card)
			card.play()
			card.queue_free()
			$AudioPlayer/CardPlace.play()
	
	if Input.is_action_just_pressed("1"):
		draw_card('Fireball')
		
	if Input.is_action_just_pressed("2"):
		draw_card('Lorem_Ipsum')

	if Input.is_action_just_pressed("3"):
		print_variables()
		draw_card_test()
		
func _on_card_mouse_entered(card: Node):
	print('_on_card_mouse_entered')
	current_card = card
	
func _on_card_mouse_exited(card: Node):
	print('_on_card_mouse_exited')
	if current_card == card:
		current_card = null

func set_active_card(card: Node):
	active_card = card

func _on_deck_mouse_entered():
	is_mouse_on_deck = true

func _on_deck_mouse_exited():
	is_mouse_on_deck = false

func test_card_hover():
	print('THIS IS A TEST')
