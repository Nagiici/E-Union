extends RigidBody2D

# 射击间隔
var shoot_direct = 0
@export var shoot_interval: float = 1.0
# 子弹速度
@export var bullet_speed: float = 200.0
# 敌人的射程
@export var range: float = 1500.0
# 子弹场景
@export var bullet_scene: PackedScene = preload("res://sence/bullet.tscn")

var timer: Timer
@onready var raycast: RayCast2D = $Sprite2D/RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready():
	$shoot_timer.start()
	$AnimationPlayer.play("idle")
func _physics_process(delta):
	# 调整 RayCast2D 的方向，使其始终朝向玩家
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		if player.global_position.x > global_position.x:
			sprite_2d.flip_h = true
			shoot_direct = 1
			raycast.target_position.x = 20
		else:
			sprite_2d.flip_h = false
			shoot_direct = -1
			raycast.target_position.x = -20
func shoot():
	"""发射子弹"""
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position
	bullet.apply_central_impulse(Vector2(bullet_speed * shoot_direct, 0))
	$AnimationPlayer.play("fire")
	get_parent().add_child(bullet)
	await $AnimationPlayer.animation_finished
	$AnimationPlayer.play("idle")
	# 调试输出：检查子弹是否已发射
	#print("Bullet fired. Position:", bullet.global_position, "Velocity:", bullet.linear_velocity)


func get_player_position() -> Vector2:
	"""获取玩家的位置，如果玩家不存在则返回零向量"""
	var player = get_tree().get_first_node_in_group("Player")
	return player.global_position if player else Vector2.ZERO

func _on_shoot_timer_timeout() -> void:
	if raycast.is_colliding():
		shoot()



func _on_hurtbox_area_entered(area: Area2D) -> void:
	$AnimationPlayer.pause()
	$AnimationPlayer.play("die")
# 等待动画完成
	await $AnimationPlayer.animation_finished

	# 销毁敌人
	queue_free()
