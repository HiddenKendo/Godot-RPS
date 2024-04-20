extends CharacterBody2D


enum teams {ROCK, PAPER, SCISSORS}

const SPEED = 100
var my_team: int
@onready var sprite_2d = $Sprite2D

@onready var rock_image = preload("res://rock.png")
@onready var paper_image = preload("res://paper.png")
@onready var scissors_image = preload("res://scissors.png")

var my_dir: Vector2


func _ready():
	my_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))


func _process(delta):
	velocity = my_dir * SPEED
	move_and_slide()
	global_position = Vector2(wrapf(global_position.x, 0, get_viewport_rect().size.x,),
							  wrapf(global_position.y, 0, get_viewport_rect().size.y,))


func update_texture(team_index: int):
	my_team = team_index
	match my_team:
		teams.ROCK:
			sprite_2d.texture = rock_image
		teams.PAPER:
			sprite_2d.texture = paper_image
		teams.SCISSORS:
			sprite_2d.texture = scissors_image
