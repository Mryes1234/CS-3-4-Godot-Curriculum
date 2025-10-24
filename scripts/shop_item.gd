extends PanelContainer

signal pressed()

@export var item: Items

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label
@onready var button: Button = %Button

func _ready():
	texture_rect.texture = item.texture
	label.text = item.itemName
	
	button.pressed.connect(on_button_pressed)

func on_button_pressed():
	pressed.emit(item)
