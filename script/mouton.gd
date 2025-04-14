extends KinematicBody2D


var position_player=Vector2(0,0)
var statut="attend"
var speed=100
var velocity=Vector2(randi(),randi()).normalized();
var timewalking=randi()%50+20
var timebeforewalking=randi()%100+100
var pose="gauche"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	################ANIMATION################################
	if pose=="gauche" and self.get_node("Sprite").scale.x<1:
		self.get_node("Sprite").scale.x+=0.1
		
	if pose=="droite" and self.get_node("Sprite").scale.x>-1:
		self.get_node("Sprite").scale.x-=0.1
	if velocity.x<0:
		pose="gauche"
	else:
		pose="droite"
		
	#################COMPORTEMENT#####################################
	if statut=="fuite":
		self.get_node("AnimationPlayer").play("fuite")
		position_player=self.get_parent().get_parent().get_parent().get_node("cat").get_node("bouge").global_position
		velocity=(position_player-self.global_position).normalized()*-speed
		move_and_slide(velocity)
	elif statut=='walk':
		self.get_node("AnimationPlayer").play("fuite")
		move_and_slide(velocity)
		timewalking-=1
		if timewalking<0:
			timewalking=randi()%50+20
			statut="attend"
	elif statut=="attend":
		self.get_node("AnimationPlayer").play("RESET")
		timebeforewalking-=1
		if timebeforewalking<0:
			timebeforewalking=randi()%100+100
			velocity=Vector2(0.5-randf(),0.5-randf()).normalized()*speed;
			statut="walk"
	

func _on_find_player_area_entered(area):
	if area.identity=="cat":
		statut="fuite"


func _on_find_player_area_exited(area):
	if area.identity=="cat":
		statut="attend"
