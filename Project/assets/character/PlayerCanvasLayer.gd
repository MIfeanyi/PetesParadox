extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	Gobal.connect("life_changed",self,"update_gui")

	pass # Replace with function body.

func set_ui_amount(ui,v):
	for i in ui.get_children():
		print(i.name)
		if(int(i.name))<=v:
			i.visible=true
		else:
			i.visible=false
			pass
		

func update_gui():
	for i in $MarginContainer/UI/Lifes.get_children():
		print(i.name)
		if(int(i.name))<=Gobal.life:
			i.visible=true
		else:
			i.visible=false
			pass
	pass

func use_grenade(v):
	print("grenade used")
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

