extends Node

var currentSong
var soundQueue: Array

class music extends RefCounted:
	var song: AudioStreamMP3
	var position: float = 0
	func _init(file: AudioStreamMP3, loop: bool = false) -> void:
		song = file
		song.loop = loop

var buzzwords: music
var fuzzybuzz: music
var heavypollination: music
var wateronwings: music

var bucketPickup: AudioStreamMP3
var water: AudioStreamMP3
var teleport: AudioStreamMP3
var seedGrowth: AudioStreamMP3

func load_mp3(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

func playMusic(song):
	if currentSong:
		currentSong.position=$MusicPlayer.get_playback_position()
	currentSong = song
	$MusicPlayer.set_stream(song.song)
	$MusicPlayer.play(song.position)
	
func playSound(sound):
	soundQueue.append(sound)
	
func _ready():
	buzzwords = music.new(load_mp3("res://Music/Buzz_Words.mp3"),true)
	fuzzybuzz = music.new(load_mp3("res://Music/Fuzzy_Buzz.mp3"),true)
	heavypollination = music.new(load_mp3("res://Music/Heavy_Pollination.mp3"),true)
	wateronwings = music.new(load_mp3("res://Music/water_on_wings_bg.mp3"),true)
	
	water = load_mp3("res://Sounds/Water.mp3")
	teleport = load_mp3("res://Sounds/Teleport.mp3")
	seedGrowth = load_mp3("res://Sounds/Seed.mp3")

func _process(_delta: float) -> void:
	if $"SFX Player".playing == false and soundQueue:
		$"SFX Player".stream = soundQueue[0]
		$"SFX Player".play()
		soundQueue.pop_front()
