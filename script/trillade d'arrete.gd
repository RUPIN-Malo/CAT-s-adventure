extends Node2D


var statut="rien"
var position_player=0
var to_cat_velo=Vector2(0,0)
var lifetime=300



func _ready():
	pass 



func _physics_process(delta):
	if statut=="to_cat":
		
		position_player=self.get_parent().get_node("cat").get_node("bouge").global_position
		to_cat_velo=(position_player-self.global_position).normalized()*-15
		self.position+=to_cat_velo
		self.name="arretezz"
		statut="fonce"
	elif statut=="fonce":
		lifetime-=1
		self.position+=to_cat_velo*5
		if lifetime<0:
			self.queue_free()
		

func _on_arrete_area_entered(area):
	if area.identity=="cat":
		self.queue_free()
