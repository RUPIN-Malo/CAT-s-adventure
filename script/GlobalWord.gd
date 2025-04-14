extends Node2D
var lvlx=10
var lvly=10

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("cat/bouge").global_position=Vector2(0,0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_borduregauche_area_entered(area):
	if area.identity=="cat":
		area.get_parent().global_position.x=-area.get_parent().global_position.x-20
		self.get_node("lvl").get_node("lvl"+str(lvlx)+","+str(lvly)).queue_free()
		lvlx-=1
		self.get_node("lvl").add_child(load("res://scene/lvl/lvl"+str(lvlx)+","+str(lvly)+".tscn").instance())
	


func _on_bordurehaut_area_entered(area):
	if area.identity=="cat":
		area.get_parent().global_position.y=-area.get_parent().global_position.y-20
		self.get_node("lvl").get_node("lvl"+str(lvlx)+","+str(lvly)).queue_free()
		lvly-=1
		self.get_node("lvl").add_child(load("res://scene/lvl/lvl"+str(lvlx)+","+str(lvly)+".tscn").instance())

func _on_borduredroite_area_entered(area):
	if area.identity=="cat":
		area.get_parent().global_position.x=-area.get_parent().global_position.x+20
		self.get_node("lvl").get_node("lvl"+str(lvlx)+","+str(lvly)).queue_free()
		lvlx+=1
		self.get_node("lvl").add_child(load("res://scene/lvl/lvl"+str(lvlx)+","+str(lvly)+".tscn").instance())
		

func _on_bordurebas_area_entered(area):
	if area.identity=="cat":
		area.get_parent().global_position.y=-area.get_parent().global_position.y+20
		self.get_node("lvl").get_node("lvl"+str(lvlx)+","+str(lvly)).queue_free()
		lvly+=1
		self.get_node("lvl").add_child(load("res://scene/lvl/lvl"+str(lvlx)+","+str(lvly)+".tscn").instance())
		
