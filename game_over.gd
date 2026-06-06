extends CanvasLayer

func _on_menu_button_pressed():
	get_tree().paused = false
	# Zmień na poprawną ścieżkę do swojego Menu Startowego
	get_tree().change_scene_to_file("res://menu.tscn")


func _on_play_button_pressed() -> void:
	get_tree().paused = false 
	# 2. Ta funkcja resetuje obecny poziom od nowa
	get_tree().reload_current_scene() 
