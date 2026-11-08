extends Node2D

# Radios de proximidad para interactuar con el gato o golpear al enemigo
@export var interaction_radius: float = 48.0
@export var attack_radius: float = 64.0

var score: int = 0

func _ready() -> void:
	# Ubicación inicial del gato y actualización de la interfaz
	$Cat.relocate()
	$Cat.position.y = $Player.position.y
	update_status()

# Actualizar el texto mostrado en el Label
func update_status() -> void:
	$StatusLabel.text = "Gatos salvados: " + str(score)

# Callback cuando el jugador presiona interactuar
func _on_player_interact_requested() -> void:
	var distance: float = $Player.global_position.distance_to($Cat.global_position)

	if distance <= interaction_radius:
		score += 1
		# Mover al gato en X y asegurar que la altura Y sea idéntica a la del jugador
		$Cat.relocate()
		$Cat.position.y = $Player.position.y
		update_status()

# Callback cuando el jugador presiona atacar
func _on_player_attack_requested() -> void:
	if has_node("Enemy"):
		var distance: float = $Player.global_position.distance_to($Enemy.global_position)
		if distance <= attack_radius:
			$Enemy.defeat()
