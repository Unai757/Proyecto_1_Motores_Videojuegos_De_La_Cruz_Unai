extends Sprite2D

# Límites horizontalmente centrados para que NUNCA se salga del marco rosa
@export var left_limit: float = -450.0
@export var right_limit: float = 450.0

# Función para mover al gato a una posición segura en pantalla
func relocate() -> void:
	position.x = randf_range(left_limit, right_limit)
