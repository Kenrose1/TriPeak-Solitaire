extends Node2D

var discard_ref = null
var cards: Array = []

var deals_left: int = 10
var remaining_cards: int = 10
var status_label: Label = null
var dialog_ref: AcceptDialog = null
var dialog_ref1: AcceptDialog = null

func _ready():
	dialog_ref = find_child("YouLostDialog")
	if dialog_ref:
		var lost_label = dialog_ref.get_label()
		lost_label.add_theme_color_override("font_color", Color("#E74C3C"))
		lost_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	dialog_ref1 = find_child("YouWinDialog")
	if dialog_ref1:
		var win_label = dialog_ref1.get_label()
		win_label.add_theme_color_override("font_color", Color("#D4AF37"))
		win_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

	discard_ref = find_child("Discard")
	status_label = find_child("StatusLabel")
	
	cards.clear()
	for i in range(10):
		var ref = find_child("Card" + str(i))
		cards.append(ref)
	
	deals_left = 10
	remaining_cards = 10
	update_status()

func update_status():
	if status_label:
		status_label.text = "Deals left: " + str(deals_left)

func play(id: int, num: int):
	
	if id < 0 or id > 9 or cards[id] == null:
		return
	
	var diff = abs(num - discard_ref.num)
	if diff != 1:
		return
	
	if id <= 5:
		var row = int(sqrt(1.75 * id))
		var top1 = int((row + 1) * (row + 2) / 2.0 + id - row * (row + 1) / 2.0)
		var top2 = top1 + 1
		
		if (top1 < cards.size() and cards[top1] != null) or (top2 < cards.size() and cards[top2] != null):
			return

	discard_ref.set_number(num)
	cards[id].set_visible(false)
	cards[id] = null
	
	remaining_cards -= 1
	update_status()
	check_win()
	check_loss()

func check_win():
	if remaining_cards <= 0:
		if status_label:
			status_label.text = "YOU WIN!"
		if dialog_ref1:
			dialog_ref1.popup_centered()

func can_play_card(id: int) -> bool:
	if id < 0 or id >= cards.size() or cards[id] == null:
		return false
	
	var diff = abs(cards[id].num - discard_ref.num)
	if diff != 1:
		return false
				
	if id <= 5:
		var row = int(sqrt(1.75 * id))
		var top1 = int((row + 1) * (row + 2) / 2.0 + id - row * (row + 1) / 2.0)
		var top2 = top1 + 1
		if (top1 < cards.size() and cards[top1] != null) or (top2 < cards.size() and cards[top2] != null):
			return false
			
	return true

func check_loss():
	if deals_left > 0 or remaining_cards <= 0:
		return
	
	for i in range(cards.size()):
		if can_play_card(i):
			return
			
	if dialog_ref:
		dialog_ref.popup_centered()		
		
	if status_label:
		status_label.text = "YOU LOSE! NO MOVES LEFT."

func _on_deal_button_pressed():
	if deals_left <= 0 or remaining_cards <= 0:
		return

	for i in range(cards.size()):
		if can_play_card(i):
			if status_label:
				status_label.text = "MOVE AVAILABLE!"
			return

	deals_left -= 1
	discard_ref.set_number(discard_ref.rand.randi_range(1, 13))
	update_status()
	check_loss()

func _on_new_game_button_pressed():
	get_tree().reload_current_scene()
