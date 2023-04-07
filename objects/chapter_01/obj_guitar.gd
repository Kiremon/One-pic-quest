extends GameObject

signal show_door;

func give_rock() ->void:
	if ! Story.has_flag("rock_acquired"):
		combine_succeeded();
		start_speech([{ "text" : "S_GUITAR_DRUMSTICK"}]);
		Story.get_inv().add_obj("rock");
		Story.set_flag("rock_acquired", true);
	else:
		combine_failed();

func play_guitar() ->void:
	if ! Story.has_flag("despair_reached"):
		start_speech([{ "text" : "S_GUITAR_MUSBOOKS_BEFOR"}]);
	elif ! Story.has_flag("plant_watered_3"):
		start_speech([{ "text" : "S_GUITAR_MUSBOOKS_NOWATER"}]);
	elif ! Story.has_flag("door_opened"):
		combine_succeeded();
		start_speech([
			{ "text" : "S_GUITAR_MUSBOOKS_AFTER_1"},
			{ "text" : "S_GUITAR_MUSBOOKS_AFTER_2"}]);
		Ui.on_speech_stoped(emit_show_door);
		Story.set_flag("door_opened", true);
		Sound.play_music("mus_ending");
	else:
		combine_failed();

func emit_show_door() ->void:
	show_door.emit();

