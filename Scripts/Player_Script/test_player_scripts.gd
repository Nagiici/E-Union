extends CharacterBody2D

# 定义常量和变量
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
const DASH_SPEED = 600  # 冲刺速度
var dash_gravity = Vector2(0, 980)  # 设定该变量为力
var canattack = true

# 当前动画状态
var current_animation = "idle 1"  # 默认动画

func _ready() -> void:
	play_animation("idle 1")  # 初始化待机动画

func _physics_process(delta: float) -> void:
	# 更新是否在地面
	is_grounded = is_on_floor()

	# 添加重力
	if not is_grounded:
		velocity.y += dash_gravity.y * delta
	else:
		velocity.y = 0  # 当角色在地面时，重置垂直速度

	# 处理逻辑
	if dashing:
		handle_dash_movement()  # 冲刺期间只执行冲刺移动逻辑
	else:
		handle_movement()  # 执行普通移动逻辑

	# 检查冲刺输入
	handle_dash()

	# 移动角色
	move_and_slide()

func handle_movement() -> void:
	var direction = Input.get_axis("left", "right")

	if direction != 0:
		velocity.x = direction * SPEED
		$AnimationPlayer.flip_h = direction > 0
		play_animation("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if abs(velocity.x) < 0.1:
			velocity.x = 0
			if is_grounded:
				play_random_idle_animation()

func handle_dash() -> void:
	if is_on_floor():
		dashenchurge = true
	# 检测是否可以冲刺（只能触发一次）
	if Input.is_action_just_pressed("dash") and canDash and dashenchurge:
		SPEED= 600
		$AnimationPlayer.play("dash")
		if Input.is_action_pressed("left"):
			$AnimationPlayer.flip_h = true
		if Input.is_action_pressed("right"):
			$AnimationPlayer.flip_h = false
		$DashTimer.start()
		velocity.y = 0
		canDash = false
		dashing = true
		dashing = false
		$dash_cool.start()
		dashenchurge = false
		$dash_audio.play()

# 冲刺移动逻辑
func handle_dash_movement() -> void:
	# 冲刺期间固定速度，不受其他逻辑干扰
	velocity.x = dashDirection.x * DASH_SPEED

# 动画播放逻辑，避免重复播放
func play_animation(name: String) -> void:
	if current_animation != name:
		current_animation = name
		$AnimationPlayer.play(name)

# 随机播放 idle 动画
func play_random_idle_animation() -> void:
	if current_animation != "idle 1" and current_animation != "idle 2":
		var idle_animation = "idle 1" if randi() % 2 == 0 else "idle 2"
		play_animation(idle_animation)

# 冲刺冷却计时器
func _on_dash_cool_timeout() -> void:
	canDash = true  # 允许再次冲刺
	print("Dash cooldown ended.")  # 调试输出
	
# 冲刺计时器超时
func _on_DashTimer_timeout() -> void:
	SPEED = 175
	dash_gravity = Vector2(0, 980)
	if is_grounded:
		play_random_idle_animation()  # 播放随机待机动画


