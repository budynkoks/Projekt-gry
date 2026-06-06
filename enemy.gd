extends CharacterBody2D

var health = 3
var player 
@onready var anim = $AnimatedSprite2D 
const XP_GEM_SCENE = preload("res://XPgem/x_pgem.tscn") 
func _ready():
	player = get_node("/root/Game/Player")
	
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 90.0
	move_and_slide()
	if velocity.length() > 0:
		anim.play("default") 
		
		if velocity.x > 0:
			anim.flip_h = false
		elif velocity.x < 0:
			anim.flip_h = true  
	 
func take_damage(damage):
	health -= damage
	if health <= 0:
		# 1. Tworzymy klejnot
		var gem = XP_GEM_SCENE.instantiate()
		
		# 2. Ustawiamy jego pozycję tam, gdzie zginął wróg
		gem.global_position = global_position
		
		# 3. Dodajemy go do głównego drzewa gry (używamy get_parent(), 
		# aby klejnot nie zniknął razem z wrogiem!)
		get_parent().add_child(gem)
		
		# 4. Usuwamy wroga
		queue_free()
