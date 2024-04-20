extends Node2D


enum teams {ROCK, PAPER, SCISSORS}

var my_team: int
@onready var sprite_2d = $Sprite2D

@onready var rock_image = preload("res://rock.png")
@onready var paper_image = preload("res://paper.png")
@onready var scissors_image = preload("res://scissors.png")


func update_texture(team_index: int):
	my_team = team_index
	match my_team:
		teams.ROCK:
			sprite_2d.texture = rock_image
		teams.PAPER:
			sprite_2d.texture = paper_image
		teams.SCISSORS:
			sprite_2d.texture = scissors_image
