extends CharacterBody2D

var SPEED = 175
const JUMP_VELOCITY = -400.0
var dashDirection: Vector2 = Vector2(1, 0)
var canDash = true
var dashing = false
var is_grounded: bool = false
var jump_count = 0
var dashenchurge: bool = false
const WALL_JUMP_FORCE = Vector2(-200, -400)  # 蹬墙跳跃时的力量
var is_wall_sliding = false
var dash_gravity = Vector2(0, 980)  # 设定该变量为力
var canattack = true

@onready var collision_shape_2d: CollisionShape2D = $Sprite2D/Hitbox/CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	add_to_group("Player")
	$AnimationPlayer.play("idle")
	$walk_audio.stream_paused = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	is_grounded = is_on_floor() or is_on_wall()
	if not is_on_floor():
		velocity += dash_gravity * delta
	if is_on_floor():
		jump_count = 0
	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_grounded and jump_count == 0:
			velocity.y = JUMP_VELOCITY  # First jump when grounded
			jump_count = 1  # Set jump count to 1
			is_grounded = false  # Character is now in the air
			$AnimationPlayer.play("jump_1")
			$jump_1_audio.play()
		elif not is_grounded and is_wall_sliding == false and (jump_count == 1 or jump_count == 0):
			velocity.y = JUMP_VELOCITY * 60/100
			jump_count = 2
			$AnimationPlayer.play("jump_2")
			$jump_2_audio.play()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction == 1:
		collision_shape_2d.position.x = 950
	else:
		collision_shape_2d.position.x = 900

	# 检查攻击输入
	if Input.is_action_just_pressed("attack") and canattack:
		attack()
	walk_animation()

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	dash()
	if is_on_wall():
		is_wall_sliding = true
	
	if is_on_wall() and velocity.y >0:
		velocity.y = 50
	# 检查蹬墙跳跃
	if is_wall_sliding and Input.is_action_just_pressed("jump"):
		wall_jump()
		is_wall_sliding = false
		
	if Input.is_action_pressed("left"):
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = true
	# 移动角色
	move_and_slide()  # 不需要传递参数，Godot 会自动使用 velocity



func wall_jump():
	# 根据角色在墙上的方向施加蹬墙跳跃力
	var wall_dir = -1 if is_on_left_wall() else 1  # 左墙为 -1，右墙为 1
	velocity = Vector2(WALL_JUMP_FORCE.x * wall_dir, WALL_JUMP_FORCE.y)  # 直接设置 velocity
	$jump_2_audio.play()
	$AnimationPlayer.play('jump_2')

func is_on_left_wall():
	# 判断角色是否接触左侧墙壁
	return is_on_wall() and get_wall_normal().x > 0

func is_on_right_wall():
	# 判断角色是否接触右侧墙壁
	return is_on_wall() and get_wall_normal().x < 0

func dash():
	if is_on_floor():
		dashenchurge = true

	if Input.is_action_just_pressed("dash") and canDash and dashenchurge:
		SPEED = 500
		$AnimationPlayer.play("dash")
		$DashTimer.start()
		$dash_audio.play()
		$dash_cool.start()
		velocity.y = 0
		canDash = false
		dashing = true
		dashing = false
		dashenchurge = false

func walk_animation():
	if velocity.x != 0 and is_on_floor() and SPEED == 175:
		$AnimationPlayer.play("walk")
		if not $walk_audio.playing:
			$walk_audio.stream_paused = false
		$walk_timer.start()
	elif velocity.x == 0 or not is_grounded:
		$walk_audio.stream_paused = true

func attack():
	$AnimationPlayer.play('attack')  # 播放攻击动画
	$attack_audio.play()
	$attack_cool.start()
	$attack_yansi.start()
	$walk_timer.stop()
	canattack = false
	await $AnimationPlayer.animation_finished

func _on_dash_cool_timeout() -> void:
	canDash = true

func _on_dash_timer_timeout() -> void:
	SPEED = 175
	dash_gravity = Vector2(0, 980)
	if velocity == Vector2.ZERO:  # 待机动画
		$AnimationPlayer.play("idle")

func _on_attack_cool_timeout() -> void:
	canattack = true

func _on_attack_yansi_timeout() -> void:
	if velocity == Vector2.ZERO:  # 待机动画
		$AnimationPlayer.play("idle")

func _on_walk_timer_timeout() -> void:
	if velocity == Vector2.ZERO:  # 待机动画
		$AnimationPlayer.play("idle")

func _on_hazarddetectord_area_entered(area: Area2D) -> void:
	$hurt.play()
	await $hurt.finished 
	get_tree().reload_current_scene()
