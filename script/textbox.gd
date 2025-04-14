extends MarginContainer

onready var label= $MarginContainer/Label
onready var timer= $letterDisplayTimer

var text=""
var letter_index=0

var letter_time=0.02
var space_time=0.06
var ponctuation_time=0.2


signal finished_displaying()



func display_text(text_to_display:String):
	text=text_to_display
	label.text=text_to_display
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
