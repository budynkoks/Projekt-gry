extends CanvasLayer

@onready var container = $VBoxContainer
var current_options = []

func setup_ui(options):
	current_options = options
	var buttons = container.get_children() # Pobiera nasze 3 przyciski
	
	for i in range(buttons.size()):
		if i < options.size():
			# Jeśli mamy wylosowaną opcję, pokazujemy przycisk i zmieniamy tekst
			buttons[i].show()
			buttons[i].text = options[i]["title"] + "\n" + options[i]["desc"]
			
			# Odpinamy stare sygnały (zabezpieczenie przed błędami przy kolejnych awansach)
			if buttons[i].pressed.is_connected(_on_button_pressed):
				buttons[i].pressed.disconnect(_on_button_pressed)
				
			# Podpinamy sygnał na nowo, przekazując mu indeks (0, 1 lub 2)
			buttons[i].pressed.connect(_on_button_pressed.bind(i))
		else:
			# Ukrywamy przycisk, jeśli w puli zostało mniej niż 3 ulepszenia
			buttons[i].hide()

func _on_button_pressed(index):
	var chosen_upgrade = current_options[index]
	
	# Wysyłamy informację do gracza, które ulepszenie zostało wybrane
	owner.apply_upgrade(chosen_upgrade["id"]) # "owner" odnosi się do węzła Player
	
	hide() # Ukrywamy UI
	get_tree().paused = false # Wznowienie gry
