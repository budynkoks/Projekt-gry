extends Area2D

var travelled_distance = 0.0
var damage = 1.0 # Wartość domyślna. Zostanie od razu nadpisana przez broń w momencie strzału!
@onready var hit = %HitSoundWand

func _physics_process(delta):
	const SPEED = 300.0
	const RANGE = 700.0
	
	# Kierunek w prawo, ale obrócony o kąt, w jakim wyleciał z lufy
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
	
	set_physics_process(false)
	hide()
	
	$CollisionShape2D.set_deferred("disabled", true)
	hit.play()
	await hit.finished
	
	queue_free()
