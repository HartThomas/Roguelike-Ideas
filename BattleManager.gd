extends Node
@export var battleInfo : BattleInfo
@export var card_resource : CardStats
@export var cards_to_offer : Array[Resource]
@export var card_zoom_scene = preload("res://card_zoom.tscn")

@export var player = {max_health = 50, health = 50, block = 0, status_list = []}
@export var enemy = {max_health = 5, health = 5, block = 0, status_list = []}

@export var max_physical_effort :int = 1
@export var physical_effort :int = 1

@export var max_fire_effort: int = 0
@export var fire_effort:int = 0

@export var max_holy_effort :int = 0
@export var holy_effort :int = 0

@export var max_blood_effort: int = 0
@export var blood_effort:int = 0

@export var max_mental_effort: int = 0
@export var mental_effort: int = 0

@export var starting_effort_values: Dictionary = {max_physical_effort = 1, max_fire_effort = 0, max_holy_effort = 0, max_blood_effort= 0, max_mental_effort = 0}

var starter_options : Array[Dictionary] = [{name = 'Fire', cards = ['Torch', 'Burn', 'Augment']}, {name = 'Holy', cards = ['Pray', 'Conviction', 'Psionics']}, {name = 'Blood', cards = ['Fleam', 'Adrenaline', 'Conserve']}]

@export var card_array : Array[String] = ['Hit', 'Hit', 'Block', 'Block']

var all_cards: Array[String] = ['Hit', 'Burn', 'Conserve', 'Torch', 'Augment', 'Block', 'Forget', 'Pray', 'Conviction', 'Fleam', 'Adrenaline', 'Psionics', 'Brand', 'Spark','Coagulate','Scab','Leech','Smite','Divination','Stun','Possess','Unravel', 'Hemorrhage']

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	form_new_deck()
	add_cards_to_deck(card_array)

func add_cards_to_deck(array)-> void :
	for card in array:
		var resource_path = "res://resources/%s.tres" % [card.to_lower()]
		var new_card = load(resource_path).duplicate()
		new_card.set_local_to_scene(true)
		battleInfo.add_card_to_deck(new_card)
	battleInfo.shuffle_deck()

func form_new_deck() -> void:
	var new_battle_info = load("res://resources/battle_info.tres")
	battleInfo = new_battle_info

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func edit_enemy_stats(enemy_stats: Enemy) -> void:
	enemy.max_health = enemy_stats.max_health
	enemy.health = enemy_stats.starting_health
	enemy.block = enemy_stats.starting_block

func edit_cards_to_offer(cards: Array[String]) -> void :
	cards_to_offer.clear()
	if cards.size() == 0:
		cards = ['Hit', 'Conserve', 'Forget']
	for card in cards:
		var resource_path = "res://resources/%s.tres" % [card.to_lower()]
		var new_card = load(resource_path)
		new_card.set_local_to_scene(true)
		cards_to_offer.push_back(new_card)

func random_cards(number: int, card_array: Array[String]) -> Array[String]:
	var copy_array = card_array.duplicate()
	var result : Array[String] = []
	for i in range(min(number, copy_array.size())):
		var card = copy_array.pick_random()
		result.append(card)
		copy_array.erase(card)
	return result

func card_zoom(card)-> void:
	var zoom_overlay = card_zoom_scene.instantiate()
	zoom_overlay.card_stats = card.card_info
	get_tree().current_scene.add_child(zoom_overlay)

func reset_stats() -> void:
	card_array = ['Hit', 'Hit', 'Block', 'Block']
	starting_effort_values = {max_physical_effort = 1, max_fire_effort = 0, max_holy_effort = 0, max_blood_effort= 0, max_mental_effort = 0}
	enemy = {max_health = 5, health = 5, block = 0, status_list = []}
	player = {max_health = 50, health = 50, block = 0, status_list = []}
	max_physical_effort  = 1
	physical_effort  = 1
	max_fire_effort = 0
	fire_effort = 0
	max_holy_effort  = 0
	holy_effort  = 0
	max_blood_effort = 0
	blood_effort = 0
	max_mental_effort = 0
	mental_effort = 0
	battleInfo.reset_deck()
	add_cards_to_deck(card_array)
