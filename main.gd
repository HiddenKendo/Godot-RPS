extends Node2D


enum teams {ROCK, PAPER, SCISSORS}

var player_scene: PackedScene = preload("res://player.tscn")
@export_range(1, 1000) var num_players: float = 50

var player_array: Array


func _ready():
	$CanvasLayer/Label.hide()
	for i in int(num_players):
		spawn_player()


func _process(delta):
	get_amount_teams()


func spawn_player():
	var player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_array.append(player_instance)
	player_instance.global_position = Vector2(randf() * get_viewport_rect().size.x,
											  randf()  * get_viewport_rect().size.y)
	
	var random_team_index: int = randi_range(0, 2)
	player_instance.update_team(random_team_index)
	
	player_instance.converted_someone.connect(on_converted_someone)


func get_amount_teams():
	var rock_amount: int
	var paper_amount: int
	var scissors_amount: int
	for i in player_array.size():
		match player_array[i].my_team:
			0: rock_amount += 1
			1: paper_amount += 1
			2: scissors_amount += 1
	
	var format_string = "Rocks-🥌: %s   Papers-🧻: %s   Scissors-✂: %s"
	$CanvasLayer/AmountLabel.text = format_string % [rock_amount, paper_amount, scissors_amount]


func on_converted_someone():
	var previous_player_team: int
	for i in player_array.size():
		if i == 0:
			previous_player_team = player_array[i].my_team
		else:
			if not player_array[i].my_team == previous_player_team:
				return
			else:
				previous_player_team = player_array[i].my_team
	
	$CanvasLayer/Label.show()
	$CanvasLayer/Label.text = teams.keys()[previous_player_team] + " WON THE GAME!!"
	get_tree().paused = true
