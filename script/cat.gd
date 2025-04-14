extends Node2D
var result = 0
var velocity=Vector2(0,0)
var speed=300
var pos="face"
var heart=8
var identity="cat"
var timetogetdamage=40
var cantakedamage=true
var time_attaking=30
var attaking=false
var blocking=false
var stun=false
var time_stun=60
var canmoove=true
var npelotte=3



# METTRE L'ACTUALISATION DES PELOTTES BG


# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("heart").animate(8)
	self.get_node("bouge/hitbox/CollisionShape2D").disabled=true
	self.get_node("bouge/blocbox/CollisionShape2D").disabled=true
	self.get_node("npelotte").npelotte("x3")
	pass # Replace with function body.


func _physics_process(delta):
	velocity=self.get_node("CanvasLayer/Joystick").get_velo()*speed
	

	
	#########ANIMATION########################################
	if !attaking and !stun and !blocking:
		if pos=="face":#si on est de face
			if velocity==Vector2(0,0):#si on est a l'arrêt

				self.get_node("bouge").get_node("AnimationPlayer").play("stand face")
			else:#si on est en mouvement 
				self.get_node("bouge/AnimationPlayer").play("course face")
				if velocity.y<0:#si on change de position
					pos="dos"
					self.get_node("bouge/Sprite").scale.x=-0.3#inversion du srpite
		else:#si on est de dos
			
			if velocity==Vector2(0,0):#si on est a l'arrêt
				self.get_node("bouge").get_node("AnimationPlayer").play("stand dos")
			else:#si on est en mouvement 
				self.get_node("bouge/AnimationPlayer").play("crouse dos")
				if velocity.y>0:#si on change de position
					pos="face"
					self.get_node("bouge/Sprite").scale.x=-0.3#inverstion du sprite
				
		if self.get_node("bouge/Sprite").scale.x<0.3:#si le sprite à été renversé 
			self.get_node("bouge/Sprite").scale.x+=0.03#le remttre petit à petit à sa forme d'origine
		
		
		

	#########PELOTTE########################################
	if Input.is_action_just_pressed("pelotte") and velocity!=Vector2(0,0) and npelotte>0:
		get_parent().add_child(load("res://scene/pelotte.tscn").instance())
		self.get_node("heart").animate(heart)
		npelotte-=1#enlever une pelotte
		self.get_node("npelotte").npelotte("x"+str(npelotte))#afficher le nombre de pelotte restante
		self.get_parent().get_node("Camera").shaking(20,5)#bouger la caméra
		self.get_node("pelottesound").play()#jouer le son de lancer
		
	###################DEPLACEMENT##############################
	if canmoove:
		self.get_node("bouge").move_and_slide(velocity)
	
	####################PRENDRE UN HIT########################
	if cantakedamage==false:
		self.get_parent().get_node("Camera").shaking(2,10)
		timetogetdamage-=1
		if timetogetdamage%16==0:
			self.get_node("bouge").hide()
		elif timetogetdamage%8==0:
			self.get_node("bouge").show()
		if timetogetdamage<0:
			cantakedamage=true
			timetogetdamage=40
			self.get_node("bouge").show()
			
	####################COUP D'EPE########################
	if Input.is_action_just_pressed("attaque") and !attaking and !stun and !blocking:
		self.get_parent().get_node("Camera").shaking(20,5)
		self.get_node("swordsound").play()
		attaking=true
		time_attaking=30
		if velocity.x<0:
			self.get_node("bouge/Sprite").scale.x=0.3
			self.get_node("bouge/hitbox/CollisionShape2D").position.x=-abs(self.get_node("bouge/hitbox/CollisionShape2D").position.x)
		else:
			self.get_node("bouge/hitbox/CollisionShape2D").position.x=abs(self.get_node("bouge/hitbox/CollisionShape2D").position.x)
			self.get_node("bouge/Sprite").scale.x=-0.3
		
	if attaking:
		time_attaking-=1
		self.get_node("bouge/AnimationPlayer").play("attaque")
		if time_attaking<0:
			attaking=false
	####################BLOCAGE########################
	if Input.is_action_pressed("contre") and !stun and !attaking:
		blocking=true
		self.get_node("bouge/Sprite").scale.x=0.3
		
	if blocking:
		canmoove=false
		self.get_node("bouge/blocbox/CollisionShape2D").disabled=false
		self.get_node("bouge/AnimationPlayer").play("bloc")
		if Input.is_action_just_released("contre"):
			blocking=false
			canmoove=true
	if Input.is_action_just_released("contre"):
		self.get_node("bouge/blocbox/CollisionShape2D").disabled=true
	####################stunt########################
	if stun:
		self.get_node("bouge/Sprite").scale.x=0.3
		canmoove=false
		blocking=false
		if time_stun%7==0:
			self.get_node("bouge/blocbox/CollisionShape2D").disabled=true
		self.get_node("bouge/AnimationPlayer").play("stunt")
		time_stun-=1
		if time_stun<0:
			canmoove=true
			stun=false
			time_stun=60
			self.get_node("bouge/blocbox/CollisionShape2D").scale=Vector2(1,1)




func get_velo():
	return velocity



func _on_hurtbox_area_entered(area):

	if area.identity=="milk":
		if heart<8:
			heart+=1
		self.get_node("heart").animate(heart)
		self.get_node("healsound").play()
	elif area.identity=="arrete":
		loosehp(2)
	elif area.identity=="poisson2hurtbox":
		if area.get_parent().statut=="charge":
			loosehp(2)
	elif area.identity=="pelotte_item":
		npelotte+=1
		self.get_node("npelotte").npelotte("x"+str(npelotte))
		self.get_node("new_pelottesound").play()
		area.queue_free()
	elif area.identity=="hitbox_poule":
		loosehp(2)
	elif area.identity=="hitbox_mob_pierre2":
		loosehp(3)
		
func loosehp(hp):
	if cantakedamage:
		self.get_node("takedamagesound").play()
		heart-=hp
		self.get_node("heart").animate(heart)
		cantakedamage=false


func _on_blocbox_area_entered(area):
	if area.identity=="poisson_hurtbox":
		stop_bloc()
	elif area.identity=="poisson2hurtbox":
		stop_bloc()
	elif area.identity=="arrete":
		stop_bloc()
		
		
func stop_bloc():
	self.get_node("bouge/blocbox/CollisionShape2D").scale=Vector2(2,2)
	stun=true
	
