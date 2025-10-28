extends CharacterBody2D

signal new_item_added(item: Items)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var shop_item_grid: GridContainer = %ShopItemGrid
@onready var shop_page: PanelContainer = %ShopPage
@onready var confirm_window: PanelContainer = %ConfirmWindow

const SHOP_ITEM = preload("res://scenes/shop_item.tscn")

func _ready() -> void:
	shop_page.hide()    
	confirm_window.hide()
	_refresh_shop_items()

func _refresh_shop_items():
	for child in shop_item_grid.get_children():
		child.queue_free()
	
	for item: Items in GameManager.shopitems:
		var shopitemNode = SHOP_ITEM.instantiate()
		shopitemNode.item = item
		shop_item_grid.add_child(shopitemNode)
		shopitemNode.pressed.connect(on_item_selected)

func on_item_selected(itemResource: Items):
	confirm_window.text = "Do you want to buy %s ?" % itemResource.item_name
	confirm_window.show()
	
	var confirm = await confirm_window.confirmed
	
	if confirm:
		_item_bought(itemResource)

func _item_bought(item: Items):
	GameManager.shopItems.erase(item)
	_refresh_shop_items()
	new_item_added.emit()

func _on_shop_radius_body_entered(_body: Node2D) -> void:
	shop_page.visible = not shop_page.visible

func _on_shop_radius_body_exited(_body: Node2D) -> void:
	if shop_page.visible: shop_page.hide()

func _on_detect_radius_body_entered(_body: Node2D) -> void:
	if _body is Player:
		animated_sprite.play("Wave")

func _on_detect_radius_body_exited(_body: Node2D) -> void:
	if _body is Player:
		animated_sprite.play("Idle")
