extends Area2D

var xp_value = 10 

func _on_body_entered(body):
	if body.has_method("gain_xp"):
		body.gain_xp(xp_value)
		queue_free() 
