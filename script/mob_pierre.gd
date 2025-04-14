extends KinematicBody2D
var heart=3
var position_player=Vector2(0,0);
var tmp_avant_attaque=100+randi()%100
var tmp_charge_attaque=50+randi()%100
var tmp_apres_attaque=30
var statut="attend"
var loaded=false
var angle=0
var arrete_velo=Vector2(0,0)
var time_hited=30

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _physics_process(delta):
	###################ANIMATION####################
	position_player=self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position
	if (position_player.x-self.global_position.x)<0:
		self.get_node("Sprite").scale.x=-1
	else:
		self.get_node("Sprite").scale.x=1
		
	if statut=="attend":
		self.get_node("AnimationPlayer").play("caché")
		########fin du temps d'attente###################
		tmp_avant_attaque-=1
		if tmp_avant_attaque<0:
			tmp_avant_attaque=randi()%50+100
			statut="charge"
			
	if statut=="charge":
		#############création des arrêtes (animation)###################
		self.get_node("AnimationPlayer").play("coucou")
		if !loaded:
			self.add_child(load("res://scene/arrete.tscn").instance())
			loaded=true
			self.get_node("arrete").scale=Vector2(1,1)
		########rotation et déplacement des arrête avec le poisson#####################
		if self.has_node("arrete"):
			self.get_node("arrete").global_position=self.global_position+(position_player-self.global_position).normalized()*40
			self.get_node("arrete").look_at(self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position)
		
		###########relachement des arrêtes#########################
		tmp_charge_attaque-=1#décompte avant le relachement
		if tmp_charge_attaque<0:#lorsque le décompte est à 0
			tmp_charge_attaque=randi()%50+50
			statut='après_attaque'
			loaded=false
			arrete_velo=(position_player-self.global_position).normalized()
			if self.has_node("arrete"):
				self.get_node("arrete").statut="fonce"
				self.get_node("arrete").to_cat_velo=arrete_velo
				self.get_node("arrete").name="arrete used"
	
	
	
	if statut=="après_attaque":
		self.get_node("AnimationPlayer").play("coucou")
		########fin du temps d'attente###################
		tmp_apres_attaque-=1
		if tmp_apres_attaque<0:
			tmp_apres_attaque=randi()%50+100
			statut="attend"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_mob_pierre_hurtbox_area_entered(area):
	if area.identity=="cat_sword" :
		if statut!="attend":
			take_hit()
		else:
			self.get_parent().get_parent().get_parent().get_node("cat").stun=true
			self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge/hitbox/CollisionShape2D").disabled=true
	if area.identity=="pelotte":
		take_hit()
		take_hit()
		take_hit()
		
		
		
func take_hit():
	self.get_node("enemy_take_damage").play()
	heart-=1
	if heart<1:
		die()
	statut="attend"
	tmp_avant_attaque=randi()%50+100
	
func die():
	if randi()%3==0:
		var drop1=preload("res://scene/milk.tscn").instance()
		drop1.position=self.global_position
		self.get_parent().add_child(drop1)
	self.queue_free()
	
	var drop2=preload("res://scene/pelotte_item.tscn").instance()
	drop2.position=self.global_position+Vector2(-50+randi()%100,-50+randi()%100)
	self.get_parent().add_child(drop2)
	var dead_animation=preload("res://scene/dead_mob.tscn").instance()
	dead_animation.position=self.global_position
	self.get_parent().add_child(dead_animation)
	self.queue_free()
