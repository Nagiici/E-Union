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
		$DashTimer.start()
		dash_gravity = Vector2.ZERO  
		canDash = false
		dashing = true
		dashing = false
		$dash_cool.start()
		dashenchurge = false



	


func _on_dash_cool_timeout() -> void:
	canDash = true

func _on_dash_timer_timeout() -> void:
	SPEED = 200
	dash_gravity = Vector2(0, 980)
