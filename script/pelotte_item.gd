extends Area2D
var identity="pelotte_item"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):

	self.get_node("Sprite").scale.x-=0.04
	if self.get_node("Sprite").scale.x<-1:
		self.get_node("Sprite").scale.x=1
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
