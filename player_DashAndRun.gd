extends Area2D
@export var speed = 200 #速度
var screen_size #界面大小
var dash_is_ready: bool = true
func _ready() -> void:
	screen_size = get_viewport_rect().size



func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO # 获取界面大小
	if Input.is_action_pressed("right"): #右移动
		velocity.x += 1
		$AnimatedSprite2D.play('walk')
		$AnimatedSprite2D.flip_h = false
		
	if Input.is_action_pressed("left"): #左移动
		velocity.x -= 1
		$AnimatedSprite2D.play('walk')
		$AnimatedSprite2D.flip_h = true
		
	if velocity == Vector2.ZERO: #待机动画
		$AnimatedSprite2D.play('idel')
		
	if Input.is_action_pressed("dash") and dash_is_ready: #冲刺
		dash_is_ready = false
		dash()
		$DashCoolTimer.start()
	if speed == 600:
		$AnimatedSprite2D.play("dash")

	velocity = velocity * speed
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size) #规定在界面内移动
	
	
func dash():
	speed = 600
	$DashTimer.start()

func _on_timer_timeout() -> void:
	speed = 200


func _on_dash_cool_timer_timeout() -> void:
	dash_is_ready = true
