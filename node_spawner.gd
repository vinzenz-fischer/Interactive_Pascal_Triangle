extends Node2D

@onready var slider = $CanvasLayer/HSlider
@onready var label = $CanvasLayer/HSlider/RichTextLabel
@onready var container = $TriangleNodeContainer
const node = preload("res://PascalTriangleNode.tscn")
var n = 1
var desired_n = pow(2, 7)

func _ready():
	var newNode = node.instantiate()
	newNode.k = 0
	newNode.n = 0
	newNode.value = 1
	container.add_child(newNode)

func _process(_delta):
	if slider.value_changed:
		label.text = "[center]%d" % slider.value
		
		for child in container.get_children():
			child.update_color(slider.value)
	if n < desired_n:
		spawn_pascal_row(n)
		n += 1

func spawn_pascal_row(n_: int):
	var newNode: Node2D
	for k in n+1:
		newNode = node.instantiate()
		newNode.k = k
		newNode.n = n_
		newNode.value = get_value_by_adding(k, n)
		container.add_child(newNode)

func get_value_by_adding(k: int, n_: int):
	var result = 0
	var p = container.get_node_or_null("%d,%d" % [k-1, n_-1])
	if p != null: result += p.value
	
	p = container.get_node_or_null("%d,%d" % [k, n_-1])
	if p: result += p.value
	return result
