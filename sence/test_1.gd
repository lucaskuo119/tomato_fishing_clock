extends Node2D

var time_left = 0
var running_check = false
var coin:int = 0
var total_time = 0




const save_path = "user://save.json"

func _ready() -> void:
	lode_game()
	
	$Control/Panel/coin_counter.text = str(coin)
	update_display()


func save_game():
	var data = {
		"coin" : coin
	}
	var file = FileAccess.open(save_path,FileAccess.WRITE)
	file.store_string(JSON.stringify(data))


func lode_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
	
		if data != null:
			coin = data.get("coin", 0)




func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	running_check = true
	total_time = time_left
	$Control/Timer.start()
	$Control/coin_timer.start()
	$Control/add_time.disabled = running_check
	$Control/mines_time.disabled = running_check
	$"Control/15minadd".disabled = running_check
	$"Control/25minadd".disabled = running_check
	$"Control/45minadd".disabled = running_check
	$"Control/60minadd".disabled = running_check
	$Control/start.disabled = running_check
	
func _on_timer_timeout() -> void:
	if time_left > 0:
		time_left -= 1
		$ProgressBar.value = (1.0 - float(time_left) / total_time) * 100
		update_display()
	else:
		$Control/Timer.stop()
		running_check = false


func _on_add_time_pressed() -> void:
	time_left += 300
	update_display()


func _on_mines_time_pressed() -> void:
	time_left = max(0,time_left - 300)
	update_display()


func update_display():
	var min = time_left/60
	var sec = time_left%60
	$Control/Label.text = "%02d:%02d" % [min,sec]


func _on_coin_timer_timeout() -> void:
	if time_left > 0:
		coin += 1
		$Control/Panel/coin_counter.text = str(coin)
		save_game()
	else :
		$Control/coin_timer.stops()
		save_game()
		


func _on_erase_save_pressed() -> void:
	coin = 0
	save_game()
	update_display()


func one_five_on_minadd_pressed() -> void:
	time_left = 900
	update_display()
func two_five_on_minadd_pressed() -> void:
	time_left = 1500
	update_display()
func fore_five_on_minadd_pressed() -> void:
	time_left = 2700
	update_display()
func six_O_on_minadd_pressed() -> void:
	time_left = 3600
	update_display()


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://sence/main_screen.tscn")
