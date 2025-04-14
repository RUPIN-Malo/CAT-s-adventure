extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func animate(heart):
	if heart == 0:
		self.get_node("Sprite/AnimationPlayer").play("none")
		self.get_node("Sprite2/AnimationPlayer").play("none")
		self.get_node("Sprite3/AnimationPlayer").play("none")
		self.get_node("Sprite4/AnimationPlayer").play("none")
		
	elif heart == 1:
		self.get_node("Sprite/AnimationPlayer").play("half")
		self.get_node("Sprite2/AnimationPlayer").play("none")
		self.get_node("Sprite3/AnimationPlayer").play("none")
		self.get_node("Sprite4/AnimationPlayer").play("none")
	elif heart == 2:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("none")
		self.get_node("Sprite3/AnimationPlayer").play("none")
		self.get_node("Sprite4/AnimationPlayer").play("none")
	elif heart == 3:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("half")
		self.get_node("Sprite3/AnimationPlayer").play("none")
		self.get_node("Sprite4/AnimationPlayer").play("none")
	elif heart == 4:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("plein")
		self.get_node("Sprite3/AnimationPlayer").play("none")
		self.get_node("Sprite4/AnimationPlayer").play("none")
	elif heart == 5:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("plein")
		self.get_node("Sprite3/AnimationPlayer").play("half")
		self.get_node("Sprite4/AnimationPlayer").play("none")
	elif heart == 6:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("plein")
		self.get_node("Sprite3/AnimationPlayer").play("plein")
		self.get_node("Sprite4/AnimationPlayer").play("none")
	elif heart == 7:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("plein")
		self.get_node("Sprite3/AnimationPlayer").play("plein")
		self.get_node("Sprite4/AnimationPlayer").play("half")
	elif heart == 8:
		self.get_node("Sprite/AnimationPlayer").play("plein")
		self.get_node("Sprite2/AnimationPlayer").play("plein")
		self.get_node("Sprite3/AnimationPlayer").play("plein")
		self.get_node("Sprite4/AnimationPlayer").play("plein")

