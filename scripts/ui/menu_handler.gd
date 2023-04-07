extends Control

@onready var btn_new_game :Node = $Panel/buttons/new_game;
@onready var btn_how_to :Node = $Panel/buttons/how_to_play;
@onready var btn_credits :Node = $Panel/buttons/credits;
@onready var btn_lang :Node = $Panel/buttons/lang;
@onready var btn_quit :Node = $Panel/buttons/quit;
@onready var info_node :Node = $info;
@onready var info_text :Node = $info/panel/RichTextLabel;
@onready var lang_node :Node = $lang;

func _ready() ->void:
	btn_new_game.pressed.connect(on_btn_new_game);
	btn_how_to.pressed.connect(on_btn_how_to);
	btn_credits.pressed.connect(on_btn_credits);
	btn_lang.pressed.connect(on_btn_lang);
	btn_quit.pressed.connect(on_btn_quit);
	Ui.register_menu(self);

func on_btn_new_game() ->void:
	#подозреваю, ручной сброс главы тут не нужен
	#Story.get_scenario_handler().remove_current_chapter();
	Story.get_scenario_global().begin();
	hide();

func on_btn_how_to() ->void:
	info_text.parse_bbcode(tr("S_HOW_TO"));
	info_node.show();

func on_btn_credits() ->void:
	info_text.parse_bbcode(tr("S_CREDITS"));
	info_node.show();;

func on_btn_lang() ->void:
	lang_node.show();

func on_btn_quit() ->void:
	get_tree().quit();

func _input(event :InputEvent) ->void:
	if event.is_action_pressed("menu"):
		accept_event();
		if info_node.is_visible() :
			info_node.hide();
		elif is_visible():
			hide();
		else:
			show();	


func show_credits() ->void:
	on_btn_credits();
	var fader :Fader = Fader.new(self, 2.0);
	add_child(fader);
	fader.fade_in();
	fader.faded.connect(func(): fader.queue_free(),CONNECT_ONE_SHOT);
