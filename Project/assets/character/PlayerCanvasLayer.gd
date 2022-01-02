extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Gobal.connect("life_changed",self,"update_gui")
	pass # Replace with function body.

func update_gui():
	for i in $MarginContainer/VBoxContainer.get_children():
		if(int(i.name))<=Gobal.life:
			i.Visible=true
		else:
			i.Visible=false
			pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
