extends Sprite2D

# Velocidad de patrulla y rango de distancia horizontal
@export var speed: float = 150.0
@export var patrol_distance: float = 200.0

var start_x: float = 0.0
var direction: int = 1

func _ready() -> void:
	# Guardar la coordenada de origen
	start_x = position.x

func _process(delta: float) -> void:
	# Movimiento horizontal continuo
	position.x += speed * direction * delta
	# Dar la vuelta al alcanzar la distancia máxima
	if abs(position.x - start_x) >= patrol_distance:
		direction *= -1

# Función llamada desde el nodo principal para destruir al enemigo
func defeat() -> void:
	queue_free()
