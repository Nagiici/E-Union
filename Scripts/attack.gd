extends Node
func attack():
	if Input.is_action_just_pressed("attack") and canattack == true:
		$AnimationPlayer.play('attack')#播放攻击动画
		$attack_audio.play()
		$attack_cool.start()
		$attack_yansi.start()
		$walk_timer.stop()
		canattack = false
