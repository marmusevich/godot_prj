extends Object
class_name UnitState

var inventory: InventoryComponent
var equipment: EquipmentComponent

var health: float = 1.0
var fatigue: float = 0.0
var morale: float = 1.0

var action_points: int = 0
var max_action_points: int = 0

var experience: int = 0

var platform: CommonEnums.Platform = CommonEnums.Platform.INFANTRY


var skills := {}
# { skill_id: { "aptitude": float, "level": int } }


func _init(def: UnitDefinition):
	assert(def != null)

	platform = def.platform

	# create inventory with base capacity
	inventory = InventoryComponent.new(def.base_carry_capacity)
	equipment = EquipmentComponent.new()

	health = def.base_health
	fatigue = def.base_fatigue
	morale = def.base_morale

	action_points = def.base_action_points
	max_action_points = def.base_action_points

	skills = def.starting_skills.duplicate()

	# add starting items
	for item_def in def.starting_items:
		inventory.add_item(ItemState.new(item_def))

	# add starting weapons (weapon definitions -> states)
	for weapon_def in def.starting_weapons:
		var ws = WeaponState.new(weapon_def)
		inventory.add_item(ws) # если хочешь хранить оружие в инвентаре

	# add starting armor
	for armor_def in def.starting_armor:
		var as = ArmorState.new(armor_def)
		inventory.add_item(as)
