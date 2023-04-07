extends GameObject

func examine() ->void:
	start_speech([{ "text" : "?"}]);

func activate_me() ->void:
	if ! Story.has_flag("door_opened"):
		return;
	Sound.play_sfx("open_door");
	Story.get_scenario_global().end();
