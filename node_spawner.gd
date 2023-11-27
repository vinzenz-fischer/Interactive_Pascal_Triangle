extends Node2D

@onready var slider = $CanvasLayer/HSlider
@onready var label = $CanvasLayer/HSlider/RichTextLabel
var color_divisor = 2
var camera = null
const node = preload("res://PascalTriangleNode.tscn")
var triangle_spawner = null

func _ready():
	triangle_spawner = await spawn_pascal_triangle(100)


func _process(_delta):
	if slider.value_changed:
		label.text = str(slider.value)
		color_divisor = int(slider.value)


func spawn_pascal_triangle(lines):
	while true:
		for n in lines:
			#print("%d! = %d" % [n, factorial(n)])
			for k in n+1:
				spawn_pascal_node_binomial(k, n, 100)
			await get_tree().process_frame

func spawn_pascal_node_binomial(k: int, n: int, size):
	var nodeName = "%d,%d" % [k, n]
	var newNode = get_node_or_null(nodeName)
	if newNode == null:
		newNode = node.instantiate()
		newNode.name = nodeName
		var k_float = float(k)
		var n_float = float(n)
		newNode.position = Vector2((k_float - n_float/2) * size, n_float * size)
		add_child(newNode)
	var value = smart_pascal(int(n), int(k))
	var colorRect = newNode.get_child(0)
	
	if value % color_divisor == 0:
		colorRect.color = Color.CADET_BLUE
	else:
		colorRect.color = Color.INDIAN_RED
	#var label = newNode.get_child(0).get_child(0)
	#label.text = "[center]%d[/center]" % value


func factorial(n):
	var result = 1
	for i in n:
		result *= i+1
	return result

func pascal(n, k): # factorial(21) is too big and causes an overflow
	var divisor = factorial(k) * factorial(n - k)
	if divisor == 0:
		print("DIVISION BY ZERO: n=%d k=%d" % [n, k])
		return 0
	return factorial(n) / divisor

# smart = manually remove factors that occour in both divident and divisor -> keeps numbers more managable
func smart_factorial(n):
	var result = []
	for i in n:
		result.append(i+1)
	return result

func smart_divide(dividents, divisors):
	var result = 1
	for factor in dividents:
		if factor in divisors:
			divisors.erase(factor)
		else:
			result *= factor
	
	for divisor in divisors:
		result /= divisor
	
	return result

func smart_pascal(n, k):
	var divisors = smart_factorial(k)
	divisors.append_array(smart_factorial(n - k))
	return smart_divide(smart_factorial(n), divisors)
