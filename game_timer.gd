extends Timer

var time_survived: float = 0.0

func _process(delta):
	# 1. Dodajemy ułamek sekundy (delta) w każdej klatce gry
	time_survived += delta
	
	# 2. Obliczamy minuty i sekundy (rzutując na liczby całkowite 'int')
	var minutes: int = int(time_survived) / 60
	var seconds: int = int(time_survived) % 60
	
	# 3. Formatujemy tekst do postaci MM:SS (np. 05:09)
	# %02d oznacza "wyświetl liczbę całkowitą, zawsze używając dwóch cyfr (dodając zero z przodu, jeśli trzeba)"
	$"../GameTimerLabel".text = "%02d:%02d" % [minutes, seconds]
