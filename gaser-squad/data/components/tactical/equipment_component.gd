extends Object
class_name EquipmentComponent

var weapon_main: WeaponState = null
var weapon_offhand: WeaponState = null

var armor_head: ArmorState = null
var armor_body: ArmorState = null
var armor_legs: ArmorState = null
var armor_full: ArmorState = null

var extra_cargo_capacity: float = 0.0
# Extra cargo capacity (дополнительная грузоподъёмность, например экзоскелет)

func equip_weapon_main(weapon: WeaponState) -> bool:
	if weapon == null:
		return false
	if weapon.definition().handling != CommonEnums.Handling.ONE_HANDED:
		return false
	weapon_main = weapon
	return true

func equip_weapon_offhand(weapon: WeaponState) -> bool:
	if weapon == null:
		return false
	if weapon.definition().handling != CommonEnums.Handling.ONE_HANDED:
		return false
	weapon_offhand = weapon
	return true

func equip_two_handed_weapon(weapon: WeaponState) -> bool:
	if weapon == null:
		return false
	if weapon.definition().handling != CommonEnums.Handling.TWO_HANDED:
		return false
	weapon_main = weapon
	weapon_offhand = null
	return true

func unequip_weapon_main():
	weapon_main = null

func unequip_weapon_offhand():
	weapon_offhand = null

func equip_armor(armor: ArmorState) -> bool:
	if armor == null:
		return false

	match armor.definition().slot:
		ArmorDefinition.ArmorSlot.HEAD:
			armor_head = armor
		ArmorDefinition.ArmorSlot.BODY:
			armor_body = armor
		ArmorDefinition.ArmorSlot.LEGS:
			armor_legs = armor
		ArmorDefinition.ArmorSlot.FULL_BODY:
			armor_full = armor
		_:
			return false
	return true

func unequip_armor(slot: int):
	match slot:
		ArmorDefinition.ArmorSlot.HEAD:
			armor_head = null
		ArmorDefinition.ArmorSlot.BODY:
			armor_body = null
		ArmorDefinition.ArmorSlot.LEGS:
			armor_legs = null
		ArmorDefinition.ArmorSlot.FULL_BODY:
			armor_full = null
