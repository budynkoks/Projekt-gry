extends Area2D

# Pobieramy referencję do Gracza (skoro broń jest jego dzieckiem w drzewku)
@onready var player = get_parent()

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	var target_enemy = null
	
	# Filtrujemy radar: szukamy pierwszego obiektu, który można zranić (wroga)
	for body in enemies_in_range:
		if body.has_method("take_damage"):
			target_enemy = body
			break 
			
	# Jeśli znaleźliśmy cel, patrzymy na niego
	if target_enemy != null:
		look_at(target_enemy.global_position)
		
func shoot():
	# UWAGA: Upewnij się, że ścieżka do pocisku się zgadza!
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	var shooting_point = $WeaponPivot/ShootingPoint
	
	# POPRAWKA 1: Dodajemy pocisk do głównego świata gry, nie do pistoletu!
	get_tree().current_scene.add_child(new_bullet)
	
	# Ustawiamy pozycję i kąt wylotu
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = shooting_point.global_rotation
	
	# POPRAWKA 2: Pobieramy obrażenia prosto od Gracza (dzięki temu działają ulepszenia!)
	if "wand_damage" in player:
		new_bullet.damage = player.wand_damage

func _on_timer_timeout() -> void:
	# Sprawdzamy czy w ogóle mamy do kogo strzelać
	var enemies_in_range = get_overlapping_bodies()
	for body in enemies_in_range:
		if body.has_method("take_damage"):
			shoot()
			break # Wystarczy, że widzimy jednego, strzelamy i przerywamy pętlę
