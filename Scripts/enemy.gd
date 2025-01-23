extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ray_cast_2d: RayCast2D = $Sprite2D/RayCast2D
var direction = 0
var alive = true
var can_attack = true
func _ready() -> void:
	$attack_timer.start()

func _physics_process(delta):
	var player = get_tree().get_first_node_in_group("Player")
	if player.global_position.x > global_position.x:
		sprite_2d.flip_h = true
		ray_cast_2d.target_position.x = 64
	else:
		sprite_2d.flip_h = false
		ray_cast_2d.target_position.x = -64


		
func attack():
	if can_attack:
		$AnimationPlayer.play("attack")
		$attack_timer.start()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if alive:
		alive = false
		can_attack = false
		$AnimationPlayer.pause()
		$AnimationPlayer.play("die")
		await $AnimationPlayer.animation_finished
		queue_free()



func _on_attack_timer_timeout() -> void:
	if ray_cast_2d.is_colliding():
		attack()
