extends Node2D

var camera = null
var node = preload()

func _ready():
	camera = get_node("Camera2D")


func _process(_delta):
	# spawn cells where cells are needed, delete cells outside of visible area
	pass

func factorial(n):
	var result = 1
	for i in n:
		result *= i+1
	return result

func pascal(n, k):
	var divisor = factorial(k) * factorial(n-k)
	return factorial(n) / divisor
