extends AnimatedSprite2D

func connect_mover(mover :Node) ->void:
	mover.movement_started.connect(start_movement);
	mover.movement_stoped.connect(stop_movement);

func start_movement(move_key :int) ->void:
	play(Thesaurus.MOVE_KEYS.find_key(move_key));
	frame = 1;

func stop_movement() ->void:
	stop();
