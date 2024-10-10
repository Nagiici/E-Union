extends Node
func _physics_process(delta: float) -> void:
	if $Node.is_alive:
		attack()
		
func attack():
	if Input.is_action_just_pressed("attack"):
		$AnimationPlayer.play('attack')#播放攻击动画
