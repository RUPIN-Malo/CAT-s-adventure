extends KinematicBody2D


var speed=100
var velocity= Vector2(0,0);
var heart=3
var position_player=Vector2(0,0);

var touchedwall=false
var time_hited=30
var statut="charge"
var tmp_avant_attaque=randi()%50+100

func _ready():
	pass
	
	

func _physics_process(delta):
	if statut=="charge":
		position_player=self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position
		velocity=(position_player+Vector2(-0.5+randf(),-0.5+randf())-self.global_position).normalized()*speed
		move_and_slide(velocity)
		self.get_node("Sprite").rotation_degrees+=5




	########################################################################################
	#statut hited: va à l'opposé du joueur, subit le recule du coup########
	if statut=="hited":
		time_hited-=1
		velocity=(position_player-self.global_position).normalized()*-(50+10*time_hited)
		move_and_slide(velocity)
		if time_hited<0:
			statut="charge"
			
			
	if statut=="attend":
		tmp_avant_attaque-=1
		if tmp_avant_attaque<0:
			statut="charge"

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
	
func take_hit():
	self.get_node("enemy_take_damage").play()
	heart-=1
	if heart<1:
		die()
	statut="hited"
	time_hited=30
	


func _on_hurtbox_poule_area_entered(area):
	if area.identity=="cat_sword":
		take_hit()
	elif area.identity=="pelotte":
		take_hit()
		die()
		area.queue_free()
		
	elif area.identity=="cat_bloc":
		statut='attend'
		tmp_avant_attaque=randi()%50+100
