extends Area2D

var identity="arrete"
var statut="rien"
var position_player=0
var to_cat_velo=Vector2(0,0)


func _ready():
	pass 


func _physics_process(delta):
	self.rotation_degrees+=20
	if statut=="fonce":
		self.global_position+=to_cat_velo*10


func _on_arrete_area_entered(area):
	if area.identity=="cat":
		self.queue_free()
	elif area.identity=="pelotte":
		self.queue_free()
	elif area.identity=="cat_sword":
		self.queue_free()
	elif area.identity=="cat_bloc":
		self.queue_free()
