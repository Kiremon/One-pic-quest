extends GameScenario

signal hide_door;

func set_flags() ->void:
	story_flags = {
		"window_examined" : false,
		"blood_examined" : false,
		"musician_acquired" : false,
		"plant_watered_1" : false,
		"plant_watered_2" : false,
		"plant_watered_3" : false,
		"despair_reached" :false,
		"rock_acquired" : false,
		"door_opened" :false
	}

func begin() ->void:
	Sound.play_music("mus_intro");
	var player :Node = chapter_handler.get_node("player");
	chapter_handler.set_player(player);
	chapter_handler.go_to_loc("ch1_balcony", 0);
	Sound.play_sfx("open_door");
	
	await chapter_handler.get_tree().create_timer(2.5).timeout;
	hide_door.emit();
