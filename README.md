# Projekt Gry (Lab 15) 

##  Opis gry — o co chodzi i jak się gra
Projekt to gra przetrwania typu **Vampire survivors** (często nazywana *Reverse Bullet Hell*). Gracz steruje postacią uwięzioną na nieskończonej arenie, na którą nieustannie napierają hordy przeciwników. 

### Zasady i cel gry:
* **Przetrwanie:** Cel gry to przetrwanie jak najdłużej (śledzone przez licznik czasu na ekranie).
* **Automatyczny atak:** Gracz nie naciska przycisku ataku – bronie (takie jak Miecz czy Magiczna Różdżka) aktywują się automatycznie w określonych odstępach czasu.
* **Rozwój postaci:** Z pokonanych wrogów wypadają klejnoty doświadczenia (EXP).
* **Ulepszenia:** Zebranie odpowiedniej ilości EXP awansuje gracza na wyższy poziom, co zatrzymuje grę i otwiera menu ulepszeń z losowymi opcjami (np. zwiększenie obrażeń, dodatkowe pociski, szybszy ruch).

###  Sterowanie:
* **Poruszanie się:** Klawisze `W`, `S`, `A`, `D` (lub Strzałki).
* **Interfejs (Menu/Game Over):** `Myszka` (wybór ulepszeń, restart gry).

---

##  Wybrany silnik i instrukcja uruchomienia projektu
* **Silnik gry:** Projekt został stworzony w silniku **Godot Engine** (wersja 4.x).
* **Język programowania:** `GDScript`.

### Instrukcja uruchomienia z poziomu kodu źródłowego:
1. Pobierz i zainstaluj silnik Godot 4 (dostępny za darmo na [godotengine.org](https://godotengine.org/)).
2. Uruchom edytor Godot i w menedżerze projektów kliknij **Import** (Importuj).
3. Wskaż plik `project.godot` znajdujący się w głównym folderze projektu (w katalogu `lab_15`).
4. Po załadowaniu projektu w edytorze, naciśnij klawisz **`F5`** (lub ikonę "Play" w prawym górnym rogu), aby uruchomić główną scenę menu.

---

##  Opis własnego mechanizmu
Względem klasycznych i najprostszych klonów tego gatunku, projekt wyróżnia się **w pełni dynamicznym, matematycznym systemem "Multi-shot"** dla broni białej (Miecz). 

Zamiast standardowego zwiększania obrażeń, system wykorzystuje algorytmy trygonometryczne (korzystając z wartości `TAU`), aby na bieżąco przeliczać pozycje i kąty ostrzy. Dzięki temu, w miarę zdobywania ulepszeń "Podwójne Cięcie", atak gracza płynnie ewoluuje z uderzenia kierunkowego w potężny, **360-stopniowy atak obszarowy (AoE)** chroniący postać z każdej strony. 

Dodatkowo zaimplementowano inteligentny system namierzania dla drugiej broni (Różdżki), która skanuje tablicę żyjących wrogów i automatycznie wektoruje pociski w stronę najbliższego zagrożenia.

---

##  Informacja czy projekt jest klonem
**Tak**, projekt jest klonem (a dokładniej wczesnym prototypem odtwarzającym rdzeń rozgrywki) popularnej gry niezależnej pt. **"Vampire Survivors"** (stworzonej przez studio *poncle* i wydanej w 2021 roku).

---

##  Znane bugi i ograniczenia
* **Spadki wydajności:** Gra nie jest zoptymalizowana pod wydajność.
* **Brak progresu:**.
* **Brak zapisywania postępu:** Po restarcie z ekranu Game Over gra nie zapisuje najwyższego wyniku (maksymalnego czasu przetrwania) pomiędzy sesjami.

##  Żródła assetów
* https://frostwindz.itch.io/pixel-art-slashes
* https://karsiori.itch.io/pixel-art-rock-pile-pack
* https://ansimuz.itch.io/gothicvania-patreon-collection
* https://pixabay.com/sound-effects/film-special-effects-sword-slash-02-266315/)


