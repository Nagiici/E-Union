# CharacterController.gd
extends Character

# Called every frame
func _process(delta: float) -> void:
	if is_alive:
		handle_input(delta)

# Method to handle player input and movement
func handle_input(delta: float) -> void:
	var direction: Vector2 = Vector2.ZERO

	# Get input from arrow keys or WASD
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normalize direction and apply speed
	if direction.length() > 0:
		direction = direction.normalized() * speed
		#position += direction * delta
		#有position之后引入
