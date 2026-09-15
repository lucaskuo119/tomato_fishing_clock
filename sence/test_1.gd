extends Node2D

var time_left = 0
var running_check = false
var coin:int = 0
const save_path = "user://save.json"


func _ready() -> void:
	lode_game()
	$Control/Panel/coin_counter.text = "🪙" + str(coin)
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
	$Control/Timer.start()
	$Control/coin_timer.start()
	$Control/add_time.disabled = running_check
	$Control/mines_time.disabled = running_check
	$an_fish.play("hook")


func _on_timer_timeout() -> void:
	if time_left > 0:
		time_left -= 1
		update_display()
	else:
		$Timer.stop()
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
		$Control/Panel/coin_counter.text = "🪙" + str(coin)
		save_game()
	else :
		$Control/coin_timer.stops()
		save_game()
		


func _on_erase_save_pressed() -> void:
	coin = 0
	save_game()
	update_display()
