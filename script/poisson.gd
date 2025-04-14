extends KinematicBody2D

var speed=100
var velocity= Vector2(0,0);
var heart=3
var position_player=Vector2(0,0);
var tmp_avant_attaque=100
var tmp_charge_attaque=100
var statut="attend"
var loaded=false
var angle=0
var arrete_velo=Vector2(0,0)
var touchedwall=false
var pose="face"
var time_hited=30

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	
	##############Animation##############
	if velocity.x==0:#bouge pas 
		self.get_node("AnimationPlayer").play("stand face")
			
	else:#bouge
			#####course face et dos########
		if velocity.y<0:#bouge vers le haut
			self.get_node("AnimationPlayer").play("course dos")
			if pose!="face":
				self.get_node("Sprite").scale.x=-1
				pose="face"
		
		else:#bouge vers le bas 
			self.get_node("AnimationPlayer").play("course face")
			if pose!="dos":
				self.get_node("Sprite").scale.x=-1
				pose="dos"
				
	if self.get_node("Sprite").scale.x<1:
		self.get_node("Sprite").scale.x+=0.1
		
	
	position_player=self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position
	#statut attend: reculer avant de charger l'attaque####################
	if statut =="attend": 
		#####déplacement##########
		velocity=(position_player-self.global_position).normalized()*-speed
		if is_on_wall():
			touchedwall=true
		if touchedwall:
			velocity=-velocity
		move_and_slide(velocity)
		
		
		########fin du temps d'attente###################
		tmp_avant_attaque-=1
		if tmp_avant_attaque<0:
			tmp_avant_attaque=randi()%50+100
			statut="charge"
			touchedwall=false
		
		
	#statut charge: tourne autour du joueur et créer trois arrête face à lui, après un certain temps les relaches
	if statut =="charge":
		velocity=Vector2(0,0)
		#############création des arrêtes (animation)###################
		if !loaded:
			self.get_parent().add_child(load("res://scene/trillade d'arrete.tscn").instance())
			loaded=true
			####pettie animation####
			if pose=="face":
				self.get_node("Sprite").scale.x=-1
				pose="dos"
		########rotation et déplacement des arrête avec le poisson#####################
		self.get_parent().get_node("trillade d'arrete").global_position=self.global_position+(position_player-self.global_position).normalized()*40
		self.get_parent().get_node("trillade d'arrete").look_at(self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position)
		
		###########relachement des arrêtes#########################
		tmp_charge_attaque-=1#décompte avant le relachement
		if tmp_charge_attaque<0:#lorsque le décompte est à 0
			tmp_charge_attaque=randi()%50+100
			statut='attend'
			loaded=false
			arrete_velo=(position_player-self.global_position).normalized()
			self.get_parent().get_node("trillade d'arrete").statut="fonce"
			self.get_parent().get_node("trillade d'arrete").to_cat_velo=arrete_velo
			self.get_parent().get_node("trillade d'arrete").name="trillade used"
			
			
	########################################################################################
	#statut hited: va à l'opposé du joueur, subit le recule du coup########
	if statut=="hited":
		time_hited-=1
		velocity=(position_player-self.global_position).normalized()*-(50+10*time_hited)
		self.get_node("AnimationPlayer").play("stand face")
		move_and_slide(velocity)
		if time_hited<0:
			statut='attend'
			
			
func _on_poisson_hurtbox_area_entered(area):
	if area.identity=="pelotte":
		area.queue_free()
		take_hit()
	elif area.identity=="cat_sword":
		take_hit()
		tmp_avant_attaque=randi()%50+100
	elif area.identity=="cat_bloc":
		statut='attend'
		tmp_avant_attaque=randi()%50+100
func die():
	if randi()%3==0:
		var drop1=preload("res://scene/milk.tscn").instance()
		drop1.position=self.global_position
		self.get_parent().add_child(drop1)
	self.queue_free()
	if randi()%3==0:
		var drop2=preload("res://scene/pelotte_item.tscn").instance()
		drop2.position=self.global_position+Vector2(-50+randi()%100,-50+randi()%100)
		self.get_parent().add_child(drop2)
	var dead_animation=preload("res://scene/dead_mob.tscn").instance()
	dead_animation.position=self.global_position
	self.get_parent().add_child(dead_animation)
	self.queue_free()
	
func take_hit():
	self.get_node("enemy_take_damage").play()
	heart-=1
	if heart<1:
		die()
	statut="hited"
	tmp_avant_attaque=randi()%50
	time_hited=30
