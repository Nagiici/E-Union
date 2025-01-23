# Character.gd
extends Node

class_name Character

var health: int = 100
var speed: float = 5.0
var is_alive: bool = true

# Method to deal damage to the character
func take_damage(damage: int) -> void:
	if is_alive:
		health -= damage
		if health <= 0:
			die()

# Method to handle character death
func die() -> void:
	is_alive = false
	get_tree().reload_current_scene()  # Remove the character from the scene
 
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('R'):
		get_tree().reload_current_scene() 


func _on_hazarddetectord_area_entered(area: Area2D) -> void:
	get_tree().reload_current_scene() 
