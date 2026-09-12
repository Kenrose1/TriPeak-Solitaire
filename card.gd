extends Sprite2D

static var rand = RandomNumberGenerator.new()

var num: int = 0 
var num_ref: RichTextLabel = null
var id: int = 0

func _ready():
	num_ref = find_child("Number")
	
	var card_name = get_name().replace("Card","")
	if card_name == "Discard":
		id = 10
	else: 
		id = int(card_name)
		
	set_number(rand.randi_range(1, 13))

func set_number(n: int):
	self.num = n
	if num_ref:
		num_ref.text = str(n)

func _on_area_2d_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		if owner and owner.has_method("play"):
			owner.play(id,num)


func _on_new_game_button_pressed():
	get_tree().reload_current_scene()
