extends Node

@onready var music_node :AudioStreamPlayer = $music;
@onready var speech_node :AudioStreamPlayer = $speech;
@onready var sfx_node :AudioStreamPlayer = $sfx;

const fade_time :float = 1.0;
const min_volume_music :float = -30.0;
var normal_volume_music :float = -10.0;
var is_music_fading :bool = false;

signal music_faded;

func _ready() ->void:
	Sound.register_sound_handler(self);
	set_process(false);

func play_music(stream :AudioStream) ->void:
	stop_music();
	await music_faded;
	music_node.stream = stream;
	#сомнительное решение с loop - его включение здесь и выключение в stop(),
	#нужно подумать над оптимизацией
	music_node.stream.loop = true;
	music_node.play();

func play_speech(stream :AudioStream) ->void:
	speech_node.stream = stream;
	speech_node.play();

func play_sfx(stream :AudioStream) ->void:
	sfx_node.stream = stream;
	sfx_node.play();

func stop_music() ->void:
	if music_node.stream != null :
		music_node.stream.loop = false;
	is_music_fading = true;
	set_process(true);

func stop_music_urgent() ->void:
	if music_node.stream != null :
		music_node.stream.loop = false;
	music_node.stop();

func stop_speech() ->void:
	speech_node.stop();

func stop_sfx() ->void:
	sfx_node.stop();

func _process(delta :float) ->void:
	if is_music_fading :
		var step :float = ((min_volume_music - normal_volume_music)
				* (delta / fade_time));
		music_node.volume_db += step;
		if music_node.volume_db <= min_volume_music:
			music_node.stop();
			is_music_fading = false;
			music_node.volume_db = normal_volume_music;
			music_faded.emit();
			set_process(false);
