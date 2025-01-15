extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.name == "background":
		# 播放音效
		self.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
