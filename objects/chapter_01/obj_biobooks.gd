extends GameObject

func give_musician() ->void:
	combine_succeeded();
	var inv :Node = Story.get_inv();
	inv.remove_obj("rock");
	inv.add_obj("musician");
	Story.set_flag("musician_acquired", true);
