extends Camera2D

var prevMousePos = null
var curZoom = 1
var minZoom = 0.04
var maxZoom = 1
var delZoom = 0.05

func _ready():
	prevMousePos = get_local_mouse_position()

func _process(_delta):
	pan()
	position.x = 0
	zoom = lerp(zoom, curZoom * Vector2.ONE, 0.1)

func _input(event):
	if event is InputEventMouseButton:
		if   Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP)   and curZoom < maxZoom:
			curZoom = min(maxZoom, curZoom + delZoom)
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN) and minZoom < curZoom:
			curZoom = max(minZoom, curZoom - delZoom)

func pan():
	var currMousePos = get_local_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		position += prevMousePos - currMousePos
	prevMousePos = currMousePos
