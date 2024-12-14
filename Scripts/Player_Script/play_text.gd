#extends CharacterBody2D
#
#
#var SPEED = 175
#const JUMP_VELOCITY = -400.0
#var dashDirection:Vector2 = Vector2(1,0)
#var canDash = true
#var dashing = false
#var is_grounded: bool = false
#var jump_count = 0
#var dashenchurge:bool = false
#const WALL_JUMP_FORCE = Vector2(-200, -400)  # 蹬墙跳跃时的力量
#var is_wall_sliding = false
#var dash_gravity = Vector2(0, 980)  #设定该变量为力
#var canattack = true
#
#func _ready() -> void:
	#$AnimationPlayer.play("idle")
#
#func _physics_process(delta: float) -> void:
	#attack()
	## Add the gravity.
	#is_grounded = is_on_floor() or is_on_left_wall() or is_on_right_wall()
	#if not is_on_floor():
		#velocity += dash_gravity * delta
		#
	## Handle jump.
	#if Input.is_action_just_pressed("jump"):
		#if is_grounded:
			#velocity.y = JUMP_VELOCITY  # First jump when grounded
			#jump_count = 1  # Set jump count to 1
			#is_grounded = false  # Character is now in the air
			#$AnimationPlayer.play("jump_1")
		#elif jump_count == 1:
			#velocity.y = JUMP_VELOCITY * 85/100  # Second jump in the air
			#jump_count = 2  # Limit to only one extra jump in the air
			#$AnimationPlayer.play("jump_2")
		#elif not is_grounded and (jump_count == 1 or jump_count == 0):
			#velocity.y = JUMP_VELOCITY * 85/100
			#jump_count = 2
			#$AnimationPlayer.play("jump_2")
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("left", "right")
	#walk_animation()
		#
	##if Input.is_action_pressed("left"):
		##$Sprite2D.flip_h = false
	##if Input.is_action_pressed("right"):
		##$Sprite2D.flip_h = true
	#
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#
	#
			#
	#
	#move_and_slide()
	#dash()
	#if is_on_wall() and velocity.y > 0:
		#is_wall_sliding = true
		#velocity.y = 50  # 设置角色下滑的速度
	#else:
		#is_wall_sliding = false
#
	## 检查蹬墙跳跃
	#if is_wall_sliding and Input.is_action_just_pressed("jump"):
		#wall_jump()
	#if Input.is_action_pressed("left"):
		#$Sprite2D.flip_h = false
	#if Input.is_action_pressed("right"):
		#$Sprite2D.flip_h = true
	## 移动角色
	#move_and_slide()  # 不需要传递参数，Godot 会自动使用 velocity
#
#
#func wall_jump():
	## 根据角色在墙上的方向施加蹬墙跳跃力
	#var wall_dir = -1 if is_on_left_wall() else 1  # 左墙为 -1，右墙为 1
	#velocity = Vector2(WALL_JUMP_FORCE.x * wall_dir, WALL_JUMP_FORCE.y)  # 直接设置 velocity
	##$AnimationPlayer.play("jump_2")
#
#func is_on_left_wall():
	## 判断角色是否接触左侧墙壁
	#return is_on_wall() and get_wall_normal().x > 0
#
#func is_on_right_wall():
	## 判断角色是否接触右侧墙壁
	#return is_on_wall() and get_wall_normal().x < 0
	#
#func dash():
	#if is_on_floor():
		#dashenchurge = true
#
#func attack():
	#if Input.is_action_just_pressed("attack") and canattack == true:
		#$AnimationPlayer.play('attack')#播放攻击动画
		#$attack_cool.start()
		#$attack_yansi.start()
		#$walk_timer.stop()
		#canattack = false
	#
	#if Input.is_action_just_pressed("dash") and canDash and dashenchurge:
		#SPEED= 600
		#$AnimationPlayer.play("dash")
		#if Input.is_action_pressed("left"):
			#$Sprite2D.flip_h = true
		#if Input.is_action_pressed("right"):
			#$Sprite2D.flip_h = false
		#$DashTimer.start()
		#velocity.y = 0
		#canDash = false
		#dashing = true
		#dashing = false
		#$dash_cool.start()
		#dashenchurge = false
#
#
		#
#func walk_animation():
	#if  velocity.x < 0 and is_on_floor() and SPEED == 175:
		#$AnimationPlayer.play("walk")
		#$walk_timer.start()
	#if velocity.x > 0 and is_on_floor() and SPEED == 175:
#
		#$dash_audio.play()
		#
#func attack():
	#if Input.is_action_just_pressed("attack") and canattack == true:
		#$AnimationPlayer.play('attack')#播放攻击动画
		#$attack_audio.play()
		#$attack_cool.start()
		#$attack_yansi.start()
		#$walk_timer.stop()
		#canattack = false
		#
#func walk_animation():
	#if  is_on_floor() and SPEED == 175:
#
		#$AnimationPlayer.play("walk")
		#$walk_timer.start()
#
#
	#
#
#
#func _on_dash_cool_timeout() -> void:
	#canDash = true
#
#func _on_dash_timer_timeout() -> void:
	#SPEED = 175
	#dash_gravity = Vector2(0, 980)
	#if velocity == Vector2.ZERO: #待机动画
		#$AnimationPlayer.play("idle")
#
#
#
#func _on_attack_cool_timeout() -> void:
	#canattack = true
#
#
#func _on_hazarddetectord_area_entered(area: Area2D) -> void:
	#get_tree().reload_current_scene() 
#
#
#func _on_attack_yansi_timeout() -> void:
	#if velocity == Vector2.ZERO: #待机动画
		#$AnimationPlayer.play("idle")
#
#
#func _on_walk_timer_timeout() -> void:
	#if velocity == Vector2.ZERO: #待机动画
		#$AnimationPlayer.play("idle")
