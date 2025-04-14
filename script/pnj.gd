extends StaticBody2D
var speak=false
var havespeak=false


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("AnimationPlayer").play("stand")

func _physics_process(delta):
	if speak and !havespeak:
		self.add_child(load("res://scene/dialog/textbox.tscn").instance())
		self.get_node("text box").display_text("Veux tu m'aider ?")
		self.get_node("text box").rect_position=Vector2(60,-400)
		

func _on_Area2D_area_entered(area):
	if area.identity=="cat":
		speak=true
