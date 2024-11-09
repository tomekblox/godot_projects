extends Camera2D

var mouse_pos
var camera_pos

var dragging = false
var creating = true

@export var camera_speed = 1
@export var zoom_speed = 1.2

var real_camera_speed = camera_speed/zoom.x

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action("left_click"):
		if event.is_pressed():
			mouse_pos = event.position
			camera_pos = position
			dragging = true
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		position = (mouse_pos - event.position)*real_camera_speed + camera_pos
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		zoom *=zoom_speed
		pass
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		zoom /=zoom_speed
	real_camera_speed = camera_speed/zoom.x
