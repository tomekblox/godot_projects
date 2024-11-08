extends Camera2D

var mouse_pos
var camera_pos

var dragging = false
var creating = true

@export var camera_speed = 5

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
		position = (mouse_pos - event.position)*camera_speed + camera_pos
