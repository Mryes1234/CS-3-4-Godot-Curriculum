extends Control

@onready var shop_item_grid: GridContainer = %ShopItemGrid
@onready var shop_page: PanelContainer = %ShopPage

const SHOP_ITEM = preload("res://scenes/shop_item.tscn")

func _ready() -> void:
	shop_page.hide()
