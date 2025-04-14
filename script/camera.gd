extends Camera2D
var time=0
var intensity=0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.current=true
	
func _physics_process(delta):
	
	if time>0:
		time-=1
		self.offset=Vector2(rand_range(-intensity,intensity),rand_range(-intensity,intensity))
		if time==0:
			self.offset=Vector2(0,0)


func shaking(timee=20,intensityy=20):
	time=timee
	intensity=intensityy
