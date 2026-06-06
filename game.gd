extends Node2D


func spawn_mob():
	var new_mob = preload("res://enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
func spawn_boss():
	var boss = preload("res://characters/boss/boss.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	boss.global_position = %PathFollow2D.global_position
	add_child(boss)

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_player_health_depleted() -> void:
	$GameOver.visible = true
	get_tree().paused = true
	
func _on_boss_timer_timeout() -> void:
	%Timer.wait_time -=0.05
	spawn_boss()
