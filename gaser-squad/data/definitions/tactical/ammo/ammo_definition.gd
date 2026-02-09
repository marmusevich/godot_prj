class_name AmmoDefinition extends BaseDefinition

## Ammo type / caliber (тип боеприпаса / калибр)
@export var ammo_type: String

## Damage multiplier for this ammo (множитель урона для этого типа патронов)
@export var damage_modifier: float = 1.0

## Bonus armor penetration (бонус к пробитию брони)
@export var armor_penetration_bonus: float = 0.0

## Special effect tag (например "incendiary", "armor_piercing", "explosive")
## (тег специального эффекта, например "поджог", "бронебойный", "взрывной")
@export var special_effect: String = ""
