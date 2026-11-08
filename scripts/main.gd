extends Sprite2D

# Señales para avisar a la escena principal cuando se presiona interactuar o atacar
signal interact_requested
signal attack_requested

# Ajustes de movimiento del personaje
@export var speed: float = 300.0
@export var dash_speed: float = 800.0
@export var dash_duration: float = 0.2
@export var jump_force: float = 350.0
@export var gravity: float = 1000.0

# Variables para controlar el dash
var is_dashing: bool = false
var dash_timer: float = 0.0
var move_direction: Vector2 = Vector2.RIGHT

# Variables para el salto visual
var is_jumping: bool = false
var height: float = 0.0
var vertical_velocity: float = 0.0

func _process(delta: float) -> void:
	# Movimiento en 8 direcciones
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_up"):
		input_dir.y -= 1
	if Input.is_action_pressed("move_down"):
		input_dir.y += 1

	# Normalizar la diagonal y recordar la última dirección usada
	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		move_direction = input_dir

	# Iniciar el impulso de dash
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration

	# Aplicar el movimiento según el estado actual (dash o velocidad normal)
	if is_dashing:
		dash_timer -= delta
		position += move_direction * dash_speed * delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		position += input_dir * speed * delta

	# Iniciar el salto
	if Input.is_action_just_pressed("jump") and not is_jumping:
		is_jumping = true
		vertical_velocity = jump_force

	# Simulación de física para elevar solo la imagen visual mediante offset.y
	if is_jumping:
		height += vertical_velocity * delta
		vertical_velocity -= gravity * delta
		if height <= 0.0:
			height = 0.0
			is_jumping = false
		offset.y = -height

func _unhandled_input(event: InputEvent) -> void:
	# Emitir la señal correspondiente según la tecla presionada
	if event.is_action_pressed("interact"):
		interact_requested.emit()
	if event.is_action_pressed("attack"):
		attack_requested.emit()
