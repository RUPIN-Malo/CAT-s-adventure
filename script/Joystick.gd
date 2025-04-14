extends Area2D


onready var big_circle=$"Big circle"
onready var little_circle=$"Big circle/little circle"
var identity="joystick"

onready var max_distance=$CollisionShape2D.shape.radius

var touched=false

func _input(event):
	if event is InputEventScreenTouch:
		var distance=event.position.distance_to(big_circle.global_position)
		if not touched:
			if distance<max_distance:
				touched=true
		else:
			little_circle.position=Vector2(0,0)
			touched=false
				
			
func _physics_process(delta):
	if touched:
		little_circle.global_position=get_global_mouse_position()
		little_circle.position=big_circle.position+(little_circle.position-big_circle.position).clamped(max_distance)
		
		
func get_velo():
	var joy_velo=Vector2(0,0)
	joy_velo.x=little_circle.position.x/max_distance
	joy_velo.y=little_circle.position.y/max_distance
	return joy_velo

