extends Control

@export var messages = [
	"Aliniez frecvențe telepatice...",
	"Decodific gândurile tale...",
	"Sincronizez undele tale cerebrale...",
	"Explorez adâncurile minții tale...",
	"Accesez subconștientul..."
]

var current_message_index = 0
var input_text = ""

@onready var text_box = $TextEdit
@onready var start_button = $Button
@onready var loading_label = $LoadingLabel
@onready var result_label = $ResultLabel
@onready var timer = $Timer
@onready var cerinta = $Label
@onready var progress_bar = $ProgressBar
@onready var reset_button = $ResetButton

func _ready():
	loading_label.hide()
	result_label.hide()
	progress_bar.hide()
	reset_button.hide()
	start_button.connect("pressed", Callable(self, "_on_start_button_pressed"))
	reset_button.connect("pressed", Callable(self, "_on_reset_button_pressed"))
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_start_button_pressed():
	input_text = text_box.text
	cerinta.hide()
	text_box.hide()
	start_button.hide()
	loading_label.show()
	progress_bar.show()
	progress_bar.min_value = 0
	progress_bar.max_value = messages.size() - 1
	progress_bar.value = 0
	result_label.hide()
	current_message_index = 0
	loading_label.text = messages[current_message_index]
	timer.start(1.0) # 1 second interval for each message

func _on_timer_timeout():
	current_message_index += 1
	if current_message_index < messages.size():
		loading_label.text = messages[current_message_index]
		progress_bar.value = current_message_index
	else:
		timer.stop()
		loading_label.hide()
		progress_bar.hide()
		result_label.text = "te gandeai la: " + input_text
		result_label.show()
		reset_button.show()

func _on_reset_button_pressed():
	# Reset all elements to their initial state
	cerinta.show()
	text_box.show()
	text_box.text = ""
	start_button.show()
	loading_label.hide()
	result_label.hide()
	progress_bar.hide()
	reset_button.hide()
	current_message_index = 0
	input_text = ""
