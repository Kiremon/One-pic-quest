extends GameObject

func examine() ->void:
	if ! Story.has_flag("window_examined"):
		Story.get_inv().add_obj("commission");
		combine_succeeded();
		Story.set_flag("window_examined", true);
		Sound.play_music("mus_climax");
		start_speech([
			{ "text" : "S_WINDOW_FIRST_1", "speaker" : "customer" },
			{ "text" : "S_WINDOW_FIRST_2"},
			{ "text" : "S_WINDOW_FIRST_3"},
		]);
		return;
	start_speech([{ "text" : "S_WINDOW_NEXT"}]);
