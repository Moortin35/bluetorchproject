extends Node
class_name WallLand


var player: CharacterBody2D

func setup(character2D: CharacterBody2D):
	player = character2D
	
func update():
	wall_slide()	
	if player.is_on_wall_only():
		player.state = self
	if player.is_on_wall_only() and Input.is_action_just_pressed("ui_accept"):
		player.velocity.x = 300	* -player.last_direction
		player.velocity.y = -300
		AudioControler.play_sfx(preload("res://_assets/media/effects/jump-01.mp3"))


		
func animation():
	player.animated_sprite_2d.flip_h = player.direction > 0
	player.play_anim("wall_land")
	
func wall_slide():
	if not player.is_on_wall_only(): return 
	
	if is_facing_wall(): return
	
	if player.velocity.y >= 0:
		player.velocity.y = player.velocity.y  * 0.75
		
		if Input.is_action_pressed("ui_down"):
			player.velocity.y = player.velocity.y  * 1.3
		
func is_facing_wall():
	pass
	#return player.get_wall_normal().x == player.velocity.x
