extends Node
var dashDirection:Vector2 = Vector2(1,0)
var canDash = true
var dashing = false
var dash_gravity = Vector2(0, 980)  #设定该变量为力
func dash():
	if is_on_floor():
		dashenchurge = true
		
	
	if Input.is_action_just_pressed("dash") and canDash and dashenchurge:
		SPEED= 600
		$AnimationPlayer.play("dash")
		if Input.is_action_pressed("left"):
			$Sprite2D.flip_h = true
		if Input.is_action_pressed("right"):
			$Sprite2D.flip_h = false
		$DashTimer.start()
		velocity.y = 0
		canDash = false
		dashing = true
		dashing = false
		$dash_cool.start()
		dashenchurge = false
		$dash_audio.play()
