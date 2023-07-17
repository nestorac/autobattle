extends Path3D

var speed = 2.0
var current_distance = 0.0
var path: Path3D

func _ready():
	# Obtén una referencia al nodo Path
	path = get_node("Path3D")

func _process(delta):
	# Calcula la dirección y la distancia hacia el siguiente punto en el camino
	var point = path.get_point_position(current_distance)
	var direction = (point - transform.origin).normalized()
	var distance_to_point = direction.length()

	# Mueve el objeto móvil hacia el siguiente punto
	transform.origin += direction * min(speed * delta, distance_to_point)

	# Actualiza la distancia recorrida
	current_distance += speed * delta

	# Comprueba si el objeto móvil ha alcanzado el final del camino
	if current_distance >= path.get_curve().get_baked_length():
		current_distance = 0.0  # Reinicia el camino si ha llegado al final

	# Orienta el objeto móvil hacia la dirección del movimiento
	look_at(point, Vector3(0, 1, 0))
