extends CharacterBody2D


enum teams {ROCK, PAPER, SCISSORS}

const SPEED = 50
var my_team: int
@onready var sprite_2d = $Sprite2D

@onready var rock_image = preload("res://rock.png")
@onready var paper_image = preload("res://paper.png")
@onready var scissors_image = preload("res://scissors.png")

@onready var rock_sound = preload("res://rock.wav")
@onready var paper_sound = preload("res://paper.wav")
@onready var scissors_sound = preload("res://scissors.wav")

var my_dir: Vector2
var on_cool_down: bool = false

signal converted_someone


func _ready():
	my_dir = Vector2.RIGHT.rotated(randf_range(0, TAU))
	velocity = my_dir * SPEED


func _process(delta):
	move_and_slide()
	global_position = Vector2(wrapf(global_position.x, 0, get_viewport_rect().size.x,),
							  wrapf(global_position.y, 0, get_viewport_rect().size.y,))
	
	var info: KinematicCollision2D = move_and_collide(velocity * delta, true)
	if info:
		var other_dude = info.get_collider()
		if other_dude.on_cool_down: return
		
		var other_team: int = other_dude.my_team
		
		if my_team == teams.ROCK:
			if other_team == teams.SCISSORS:
				other_dude.update_team(teams.ROCK)
				AudioManager.play_sound(rock_sound, "SFX", 0.1)
				other_dude.velocity *= -1
				converted_someone.emit()
				velocity *= -1
				other_dude.start_cooldown()
			elif other_team == teams.PAPER:
				update_team(teams.PAPER)
				AudioManager.play_sound(paper_sound, "SFX", 0.1)
				other_dude.velocity *= -1
				converted_someone.emit()
				velocity *= -1
				start_cooldown()
			
		elif my_team == teams.PAPER:
			if other_team == teams.ROCK:
				other_dude.update_team(teams.PAPER)
				AudioManager.play_sound(paper_sound, "SFX", 0.1)
				other_dude.velocity *= -1
				converted_someone.emit()
				velocity *= -1
				other_dude.start_cooldown()
			elif other_team == teams.SCISSORS:
				update_team(teams.SCISSORS)
				AudioManager.play_sound(scissors_sound, "SFX", 0.1)
				other_dude.velocity *= -1
				converted_someone.emit()
				velocity *= -1
				start_cooldown()
			
		elif my_team == teams.SCISSORS:
			if other_team == teams.PAPER:
				other_dude.update_team(teams.SCISSORS)
				AudioManager.play_sound(scissors_sound, "SFX", 0.1)
				other_dude.velocity *= -1
				converted_someone.emit()
				velocity *= -1
				other_dude.start_cooldown()
			elif other_team == teams.ROCK:
				update_team(teams.ROCK)
				AudioManager.play_sound(rock_sound, "SFX", 0.1)
				other_dude.velocity *= -1
				converted_someone.emit()
				velocity *= -1
				start_cooldown()
		#else:
			#other_dude.velocity *= -1
			#velocity *= -1


func update_team(team_index: int):
	my_team = team_index
	match my_team:
		teams.ROCK:
			sprite_2d.texture = rock_image
		teams.PAPER:
			sprite_2d.texture = paper_image
		teams.SCISSORS:
			sprite_2d.texture = scissors_image


func start_cooldown():
	on_cool_down = true
	await get_tree().create_timer(0.2).timeout
	on_cool_down = false
