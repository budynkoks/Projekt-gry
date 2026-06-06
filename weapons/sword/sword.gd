extends Area2D

var damage = 0.0 

# Tablica (lista) przechowująca wrogów trafionych tym uderzeniem
var enemies_hit = []
@onready var hit_sound = %HitSound

func _on_body_entered(body):
	if body.has_method("take_damage") and not body in enemies_hit:
		body.take_damage(damage)
		hit_sound.play()
		
		enemies_hit.append(body) 
		
		
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
