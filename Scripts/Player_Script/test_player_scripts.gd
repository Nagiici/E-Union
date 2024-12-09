extends CharacterBody2D

var SPEED = 175
const JUMP_VELOCITY = -400.0
var dashDirection:Vector2 = Vector2(1,0)
var canDash = true
var dashing = false
var is_grounded: bool = false
var jump_count = 0
var dashenchurge:bool = false
const WALL_JUMP_FORCE = Vector2(-200, -400)  # 蹬墙跳跃时的力量
var is_wall_sliding = false
var dash_gravity = Vector2(0, 980)  #设定该变量为力
var canattack = true

func _ready() -> void:
	$AnimationPlayer.play("idle 1")  # 默认播放 idle 1

func _physics_process(delta: float) -> void:
	attack()
	is_grounded = is_on_floor()

	# 添加重力
	if not is_grounded:
		velocity += dash_gravity * delta

	# 获取输入方向并处理移动
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = direction < 0  # 左移时翻转
		if is_grounded:
			$AnimationPlayer.play("walk")  # 行走动画
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_grounded:
			play_random_idle_animation()

	# 处理跳跃
	if Input.is_action_just_pressed("jump"):
		handle_jump()

	# 检测墙壁滑动
	handle_wall_slide()

	# 检测冲刺
	dash()

	# 移动角色
	move_and_slide()

func handle_jump():
	if is_grounded:
		velocity.y = JUMP_VELOCITY
		jump_count = 1
		$AnimationPlayer.play("jump_1")
	elif jump_count == 1:
		velocity.y = JUMP_VELOCITY * 0.85
		jump_count = 27
		$AnimationPlayer.play("jump_2")

func handle_wall_slide():
	if is_on_wall() and velocity.y > 0:
		is_wall_sliding = true
		velocity.y = 50  # 设置角色下滑速度
	else:
		is_wall_sliding = false

	if is_wall_sliding and Input.is_action_just_pressed("jump"):
		wall_jump()

func wall_jump():
	var wall_dir = -1 if is_on_left_wall() else 1
	velocity = Vector2(WALL_JUMP_FORCE.x * wall_dir, WALL_JUMP_FORCE.y)
	$AnimationPlayer.play("jump_2")

func dash():
	if is_grounded:
		dashenchurge = true

	if Input.is_action_just_pressed("dash") and canDash and dashenchurge:
		SPEED = 600
		$AnimationPlayer.play("dash")
		$DashTimer.start()
		velocity.y = 0
		canDash = false
		$dash_cool.start()
		dashenchurge = false
		$dash_audio.play()

func attack():
	if Input.is_action_just_pressed("attack") and canattack:
		$AnimationPlayer.play("attack")
		$attack_audio.play()
		$attack_cool.start()
		$attack_yansi.start()
		canattack = false

func play_random_idle_animation():
	if not $AnimationPlayer.is_playing():
		var idle_animation = "idle 1" if randi() % 2 == 0 else "idle 2"
		$AnimationPlayer.play(idle_animation)

func is_on_left_wall():
	return is_on_wall() and get_wall_normal().x > 0

func is_on_right_wall():
	return is_on_wall() and get_wall_normal().x < 0

func _on_dash_cool_timeout() -> void:
	canDash = true

func _on_dash_timer_timeout() -> void:
	SPEED = 175
	dash_gravity = Vector2(0, 980)
	if velocity == Vector2.ZERO and is_grounded:
		play_random_idle_animation()

func _on_attack_cool_timeout() -> void:
	canattack = true

func _on_hazarddetectord_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene()

func _on_attack_yansi_timeout() -> void:
	if velocity == Vector2.ZERO and is_grounded:
		play_random_idle_animation()
