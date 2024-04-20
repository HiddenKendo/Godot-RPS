extends Node2D


var player_scene: PackedScene = preload("res://player.tscn")
@export_range(1, 150) var num_players: float = 50


func _ready():
	for i in int(num_players):
		spawn_player()


func spawn_player():
	var player_instance = player_scene.instantiate()
	add_child(player_instance)
	player_instance.global_position = Vector2(randf() * get_viewport_rect().size.x,
											  randf()  * get_viewport_rect().size.y)
	
	var random_team_index: int = randi_range(0, 2)
	player_instance.update_texture(random_team_index)
