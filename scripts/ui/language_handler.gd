extends Control

@onready var btn_ru :Node = $panel/VBoxContainer/ru;
@onready var btn_en :Node = $panel/VBoxContainer/en;

func _ready() ->void:
	btn_ru.pressed.connect(on_btn_ru);
	btn_en.pressed.connect(on_btn_en);

func on_btn_ru() ->void:
	TranslationServer.set_locale("ru");

func on_btn_en() ->void:
	TranslationServer.set_locale("en");
