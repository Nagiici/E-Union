class_name Hitbox
extends Area2D

signal hit(hurtbox)#攻击信号

func _init() -> void:#连接area_entered属性
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(hurtbox: Hurtbox) -> void:
	hit.emit(hurtbox)
	hurtbox.hurt.emit(self)
	
