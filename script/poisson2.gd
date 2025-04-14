extends KinematicBody2D
var speed=200
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
var pose="droite"
var time_hited=30


func _ready():
	pass 

func _physics_process(delta):
	position_player=self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position
	
	##############Animation##############
	if velocity.x==0:#bouge pas 
		self.get_node("AnimationPlayer").play("stand face")
			
	else:#bouge
			#####course face et changement de côté########
		self.get_node("AnimationPlayer").play("course face")
		if velocity.x<0:#bouge vers la droite
			if pose!="droite":
				pose="droite"
				
		
		else:#bouge vers la gauche
			if pose!="gauche":
				pose="gauche"
				
	if pose=="droite":
		if self.get_node("Sprite").scale.x<1:
			self.get_node("Sprite").scale.x+=0.1
	else:
		if self.get_node("Sprite").scale.x>-1:
			self.get_node("Sprite").scale.x-=0.1
		
		
		
		
		
	#statut attend: reste fixe
	if statut =="attend": 
		#####déplacement##########
		velocity=Vector2(0,0)
		move_and_slide(velocity)
		
		########fin du temps d'attente###################
		tmp_avant_attaque-=1
		if tmp_avant_attaque<0:
			tmp_avant_attaque=randi()%50+100
			statut="charge"
			self.get_node("attack_sound").play()
	#statut charge: fonec sur le joueur########
	if statut =="charge":
		velocity=(position_player-self.global_position).normalized()*speed
		move_and_slide(velocity)
		
		
		
		###########décompte de la course#########################
		tmp_charge_attaque-=1#décompte avant le relachement
		if tmp_charge_attaque<0:#lorsque le décompte est à 0
			tmp_charge_attaque=randi()%50+100
			statut='attend'
	#statut hited: va à l'opposé du joueur, subit le recule du coup########
	if statut=="hited":
		time_hited-=1
		velocity=(position_player-self.global_position).normalized()*-(50+10*time_hited)
		self.get_node("AnimationPlayer").play("stand face")
		move_and_slide(velocity)
		if time_hited<0:
			statut='attend'
		
			


func _on_poisson2hurtbox_area_entered(area):
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
		drop1.position=self.global_position+Vector2(-50+randi()%100,-50+randi()%100)
		self.get_parent().add_child(drop1)
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
