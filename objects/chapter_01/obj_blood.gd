extends GameObject

func examine() ->void:
	if ! Story.has_flag("blood_examined"):
		Story.set_flag("blood_examined", true);
	
	if Story.has_flag("musician_acquired"):
		start_speech([{ "text" : "S_BLOOD_AFTER"}]);
	else:
		start_speech([{ "text" : "S_BLOOD_BEFOR"}]);

func give_idealist() ->void:
	combine_succeeded();
	var inv :Node = Story.get_inv();
	inv.remove_obj("musician");
	inv.add_obj("idealist");
