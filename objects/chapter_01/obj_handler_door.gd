extends ObjectHandler

func _after_load() ->void:
	super();
	Story.get_object("guitar").show_door.connect(fade_in, CONNECT_ONE_SHOT);
	Story.get_scenario_chapter().hide_door.connect(fade_out, CONNECT_ONE_SHOT);
