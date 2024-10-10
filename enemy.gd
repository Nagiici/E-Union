extends CharacterBody2D

func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	
	queue_free()#敌人受击直接删除实体
