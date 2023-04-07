extends GameObject

func reach_despair() ->void:
	combine_succeeded();
	Story.set_flag("despair_reached", true);
	Sound.play_music("mus_despair");
	var inv :Node = Story.get_inv();
	inv.remove_obj("commission");
	inv.remove_obj("idealist");
