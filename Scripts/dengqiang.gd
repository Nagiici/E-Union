extends CharacterBody2D

const WALL_JUMP_FORCE = Vector2(-200, -400)  # 蹬墙跳跃时的力量
var is_wall_sliding = false

func _physics_process(delta):
	# 如果角色接触到墙壁并且正在下落，则进入蹬墙滑行状态
	if is_on_wall() and velocity.y > 0:
		is_wall_sliding = true
		velocity.y = 50  # 设置角色下滑的速度
	else:
		is_wall_sliding = false

	# 检查蹬墙跳跃
	if is_wall_sliding and Input.is_action_just_pressed("jump"):
		wall_jump()
	
	# 移动角色
	move_and_slide()  # 不需要传递参数，Godot 会自动使用 velocity

func wall_jump():
	# 根据角色在墙上的方向施加蹬墙跳跃力
	var wall_dir = -1 if is_on_left_wall() else 1  # 左墙为 -1，右墙为 1
	velocity = Vector2(WALL_JUMP_FORCE.x * wall_dir, WALL_JUMP_FORCE.y)  # 直接设置 velocity

func is_on_left_wall():
	# 判断角色是否接触左侧墙壁
	return is_on_wall() and get_wall_normal().x > 0

func is_on_right_wall():
	# 判断角色是否接触右侧墙壁
	return is_on_wall() and get_wall_normal().x < 0
