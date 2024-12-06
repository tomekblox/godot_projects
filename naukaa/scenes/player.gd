extends CharacterBody2D

@export var speed: float = 200.0 # Prędkość postaci
@export var map_bounds: Rect2 = Rect2(Vector2(580, 330), Vector2(1024, 1024)) # Granice mapy

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Obsługa klawiszy WASD
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

	# Normalizacja kierunku i ruch
	if direction != Vector2.ZERO:
		direction = direction.normalized()

	velocity = direction * speed
	move_and_slide()

	# Ograniczenie pozycji postaci do map_bounds
	position = clamp_position_to_bounds(position)

func clamp_position_to_bounds(pos: Vector2) -> Vector2:
	return Vector2(
		clamp(pos.x, map_bounds.position.x, map_bounds.position.x + map_bounds.size.x),
		clamp(pos.y, map_bounds.position.y, map_bounds.position.y + map_bounds.size.y)
	)
