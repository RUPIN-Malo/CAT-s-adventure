extends Area2D
var velocity=Vector2(0,0)
var speed=10
var identity="pelotte"
var timetolive=300




func _ready():
	velocity=self.get_parent().get_node("cat").get_velo().normalized()*speed
	self.position=self.get_parent().get_node("cat").get_node("bouge").position
	

func _physics_process(delta):
	self.position.x+=velocity.x
	self.position.y+=velocity.y
	timetolive-=1
	if timetolive<0:
		self.queue_free()
