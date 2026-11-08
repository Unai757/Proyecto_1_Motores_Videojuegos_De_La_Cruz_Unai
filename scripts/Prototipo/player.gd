extends Sprite2D

# Señales emitidas hacia el nodo principal cuando se ejecutan acciones
signal interact_requested
signal attack_requested

# Variables de movimiento configurables desde el Inspector
@export var speed: float = 300.0
@export var dash_speed: float = 800.0
@export var dash_duration: float = 0.2
@export var jump_force: float = 350.0
@export var gravity: float = 1000.0

# Variables de control para el Dash
var is_dashing: bool = false
var dash_timer: float = 0.0
var move_direction: Vector2 = Vector2.RIGHT

# Variables de control para el Salto visual
var is_jumping: bool = false
var height: float = 0.0
var vertical_velocity: float = 0.0

func _process(delta: float) -> void:
	# 1. Movimiento en 8 direcciones
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_up"):
		input_dir.y -= 1
	if Input.is_action_pressed("move_down"):
		input_dir.y += 1

	# Normalizar la diagonal y recordar la última dirección
	if input_dir != Vector2.ZERO:
		input_dir = input_dir.normalized()
		move_direction = input_dir

	# 2. Inicio del Dash
	if Input.is_action_just_pressed("dash") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration

	# Aplicar movimiento rápido (Dash) o normal
	if is_dashing:
		dash_timer -= delta
		position += move_direction * dash_speed * delta
		if dash_timer <= 0.0:
			is_dashing = false
	else:
		position += input_dir * speed * delta

	# 3. Inicio del Salto
	if Input.is_action_just_pressed("jump") and not is_jumping:
		is_jumping = true
		vertical_velocity = jump_force

	# Cálculo de elevación y gravedad (desplazamiento solo visual)
	if is_jumping:
		height += vertical_velocity * delta
		vertical_velocity -= gravity * delta
		if height <= 0.0:
			height = 0.0
			is_jumping = false
		offset.y = -height

func _unhandled_input(event: InputEvent) -> void:
	# Emitir señales de acción al presionar las teclas correspondientes
	if event.is_action_pressed("interact"):
		interact_requested.emit()
	if event.is_action_pressed("attack"):
		attack_requested.emit()
