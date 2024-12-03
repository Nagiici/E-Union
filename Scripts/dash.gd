extends Node

var dash_is_ready: bool = true
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("dash") and dash_is_ready: #冲刺
			dash_is_ready = false
			velocity.x += delta * 200
			dash()
			$DashCoolTimer.start()
		

func dash():
	get_node('../AnimationPlayer').play("dash")


func _on_dash_cool_timer_timeout() -> void:
	dash_is_ready = true
