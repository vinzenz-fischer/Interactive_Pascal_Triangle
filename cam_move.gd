extends Camera2D

var prevMousePos = null
var curZoom = 0.05
var minZoom = 0.05
var maxZoom = 1
var delZoom = 0.05

func _ready():
	prevMousePos = get_local_mouse_position()
	position.y = 6400

func _process(_delta):
	pan()
	zoom = lerp(zoom, curZoom * Vector2.ONE, 0.15)

func _input(event):
	if event is InputEventMouseButton:
		if   Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP)   and curZoom < maxZoom:
			curZoom = min(maxZoom, curZoom + delZoom)
		elif Input.is_mouse_button_pressed(MOUSE_BUTTON_WHEEL_DOWN) and minZoom < curZoom:
			curZoom = max(minZoom, curZoom - delZoom)
	elif event is InputEventKey:
		if event.keycode == KEY_F:
			position = Vector2(0, 6400)

func pan():
	var currMousePos = get_local_mouse_position()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position += prevMousePos - currMousePos
	prevMousePos = currMousePos
