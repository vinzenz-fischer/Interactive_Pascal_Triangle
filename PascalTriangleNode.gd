extends Node2D

@export var k: int
@export var n: int
@export var value: int = 0
const size: int = 100

func _ready():
	name = "%d,%d" % [k, n]
	position = Vector2((float(k) - float(n)/2) * size, float(n) * size)

func update_color(divisor: int):
	if value < 0:
		if divisor == 1:
			get_child(0).color = Color.LIGHT_GRAY
		elif value % divisor == 0:
			get_child(0).color = Color(0.43, 0.43, 0.43, 1)
		else:
			get_child(0).color = Color.WHITE_SMOKE
	elif value % divisor == 0:
		get_child(0).color = Color.DIM_GRAY
	else:
		get_child(0).color = Color.WHITE
	#var label = newNode.get_child(0).get_child(0)
	#label.text = "[center]%d[/center]" % value

func factorial(x: int) -> int:
	var result = 1
	for i in x:
		result *= i+1
	return result

func pascal(n_, k_) -> int: # factorial(21) is too big, causing an integer overflow
	var divisor = factorial(k) * factorial(n_ - k_)
	if divisor == 0:
		print("DIVISION BY ZERO: n=%d k=%d" % [n_, k_])
		return 0
	return factorial(n_) / divisor

# smart = manually remove factors that occour in both divident and divisor -> keeps numbers more managable
func smart_factorial(n_) -> Array:
	var result = []
	for i in n_:
		result.append(i+1)
	return result

func smart_divide(dividents, divisors) -> int:
	var result = 1
	for factor in dividents:
		if factor in divisors:
			divisors.erase(factor)
		else:
			result *= factor
	
	for divisor in divisors:
		result /= divisor
	
	return int(result)

func smart_pascal(n_, k_) -> int:
	var divisors = smart_factorial(k_)
	divisors.append_array(smart_factorial(n_ - k_))
	return smart_divide(smart_factorial(n_), divisors)
