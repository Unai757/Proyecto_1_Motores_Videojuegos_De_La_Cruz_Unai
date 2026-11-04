extends Node2D

@export var interaction_radius: float = 48.0
@export var left_limit: float = 96.0
@export var right_limit: float = 720.0

var score: int = 0
var playing: bool = true

func _ready() -> void:
	update_status()
	move_target()
	$RoundTimer.start()

func update_status() -> void:
	$StatusLabel.text = "Puntos: " + str(score)

func move_target() -> void:
	$Target.position.x = randf_range(left_limit, right_limit)
	$Target.position.y = $Player.position.y

func _on_player_interact_requested() -> void:
	if not playing:
		return
	
	var distance: float = $Player.global_position.distance_to($Target.global_position)
	
	if distance <= interaction_radius:
		score += 1
		move_target()
		update_status()

func _on_round_timer_timeout() -> void:
	playing = false
	$Player.set_process(false)
	$Player.set_process_unhandled_input(false)
	$StatusLabel.text = "Fin: " + str(score) + " puntos"
