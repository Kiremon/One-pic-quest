extends GameScenario

func begin() ->void:
	var chapter_file :String = Thesaurus.get_file_path("chapter1");
	Story.get_scenario_handler().switch_chapter(chapter_file);
	Ui.screen_block_off();
	Ui.curtain_open();

func end() ->void:
	Ui.screen_block_on();
	Ui.curtain_close();
	Ui.on_curtain_faded(func(): 
		Ui.get_menu().show_credits()
	);
