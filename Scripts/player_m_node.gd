extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

@onready var player_animSprite = $player_animSprite

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("move_left", "move_rigt")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction > 0:
		player_animSprite.flip_h = false
	elif direction < 0:
		player_animSprite.flip_h = true
		
	if is_on_floor():
		if direction == 0:
			player_animSprite.play("animSprite_idle")
		else:
			player_animSprite.play("animSprite_run")
	else:
		player_animSprite.play("animsprite_jump")

	move_and_slide()
