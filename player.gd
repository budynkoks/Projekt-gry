extends CharacterBody2D

signal health_depleted

# Baza wszystkich dostępnych ulepszeń w grze
var upgrade_pool = [
	{"id": "sword_dmg", "title": "Ostre Ostrze", "desc": "Zwiększa obrażenia miecza o 1"},
	{"id": "sword_speed", "title": "Zwinność", "desc": "Miecz atakuje 20% szybciej"},
	{"id": "sword_count", "title": "Podwójne Cięcie", "desc": "Dodaje +1 miecz do ataku"},
	{"id": "wand_dmg", "title": "Magiczna Moc", "desc": "Zwiększa obrażenia różdżki o 1"},
	{"id": "player_speed", "title": "Buty Wiatru", "desc": "Poruszasz się 15% szybciej"},
	{"id": "player_hp", "title": "Zdrowie", "desc": "Otrzymujesz HP"}
	
]

var health = 100.0
const SWORD_SCENE = preload("res://weapons/sword/sword.tscn") 

var current_xp = 0
var current_level = 1
var xp_required = 100 

# --- STATYSTYKI GRACZA I BRONI ---
var move_speed = 180.0 # DODANE: Zmienna do prędkości gracza
var weapon_damage = 3.0
var weapon_attack_speed = 2.0 
var weapon_projectile_count = 1 
var wand_damage = 1.0 

@onready var UpgradeUI = %UpgradeUI
@onready var anim = $AnimatedSprite2D 

func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	# ZMIANA: Używamy teraz zmiennej move_speed zamiast sztywnego 180
	velocity = direction * move_speed
	move_and_slide()
	
	if velocity.length() > 0:
		anim.play("run") 
		if velocity.x > 0:
			anim.flip_h = false
		elif velocity.x < 0:
			anim.flip_h = true  
	else:
		anim.play("idle") 
	
	const DAMAGE_RATE = 5.0
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		if health <= 0.0:
			health_depleted.emit()

# ZMIANA: Obsługa ilości mieczy (pętla) i przekazywanie obrażeń
func _on_sword_timer_timeout():
	for i in range(weapon_projectile_count):
		var sword = SWORD_SCENE.instantiate()
		
		# Przekazanie obrażeń
		sword.damage = weapon_damage
		add_child(sword)
		
		# --- 1. LOGIKA DLA POJEDYNCZEGO MIECZA (Klasyczne cięcie) ---
		if weapon_projectile_count == 1:
			var base_direction = 1
			if $AnimatedSprite2D.flip_h == true:
				base_direction = -1
				sword.scale.x = -1 
			sword.position = Vector2(10 * base_direction, 0)
			
		# --- 2. LOGIKA DLA WIELU MIECZY (Atak 360 stopni) ---
		else:
			# Obliczamy kąt dla obecnego miecza w pętli.
			# TAU to pełne 360 stopni. Dzieląc je przez liczbę mieczy, 
			var angle = i * (TAU / weapon_projectile_count)
			
			# Ustawiamy obrót miecza, aby ostrze patrzyło na zewnątrz okręgu
			sword.rotation = angle
			
			# Vector2.RIGHT to wektor bazowy (patrzący w prawo). 
			# Funkcja rotated(angle) kręci nim jak wskazówką zegara.
			# Mnożąc to przez 20.0, odsuwamy miecz od środka gracza o 20 pikseli.
			sword.position = Vector2.RIGHT.rotated(angle) * 20.0

func gain_xp(amount):
	
	current_xp += amount
	var fill_percentage: float = (float(current_xp) / xp_required) * 100.0
	$XPbar.value = fill_percentage
	if current_xp >= xp_required:
		level_up()

func level_up():
	current_level += 1
	current_xp -= xp_required
	xp_required = int(xp_required * 1.5)
	
	get_tree().paused = true
	
	var available_upgrades = upgrade_pool.duplicate()
	available_upgrades.shuffle() 
	
	var chosen_upgrades = available_upgrades.slice(0, 3) 
	
	UpgradeUI.setup_ui(chosen_upgrades)
	UpgradeUI.show()

# Wywoływana z poziomu interfejsu UpgradeUI
func apply_upgrade(upgrade_id):
	match upgrade_id:
		"sword_dmg":
			weapon_damage += 1.0
			
		"sword_speed":
			weapon_attack_speed *= 0.8
			if weapon_attack_speed < 0.2: 
				weapon_attack_speed = 0.2
			$sword_timer.wait_time = weapon_attack_speed 
			
		"sword_count":
			weapon_projectile_count += 1
			
		"wand_dmg":
			wand_damage += 1.0
			
		"player_speed":
			move_speed *= 1.15 # Zwiększa prędkość o 15%
		
		"player_hp":
			health += 10
	# Zamykamy UI i wznawiamy grę
	UpgradeUI.hide() 
	get_tree().paused = false
