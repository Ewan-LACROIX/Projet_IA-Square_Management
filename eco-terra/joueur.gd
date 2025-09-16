extends CharacterBody2D

@export var speed : float = 400.0
var screen_size : Vector2

func _ready():
	screen_size = get_viewport_rect().size

func _physics_process(delta):
	# 1) input
	var input_vec = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down")  - Input.get_action_strength("move_up")
	)
	if input_vec != Vector2.ZERO:
		velocity = input_vec.normalized() * speed
		$AnimatedSprite2D.play()

		# Priorité aux mouvements horizontaux
		if abs(velocity.x) > abs(velocity.y):
			$AnimatedSprite2D.animation = "walk"
			$AnimatedSprite2D.flip_h = velocity.x < 0
		else:
			if velocity.y < 0:
				$AnimatedSprite2D.animation = "down"
			else:
				$AnimatedSprite2D.animation = "up"
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.stop()

	# 2) déplacement + collisions
	move_and_slide()
	
	
