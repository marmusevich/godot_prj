extends BaseDefinition
class_name AmmoDefinition

@export var ammo_type: String # Ammo type / caliber (тип боеприпаса / калибр)

@export var damage_modifier: float = 1.0 # Damage multiplier for this ammo (множитель урона для этого типа патронов)

@export var armor_penetration_bonus: float = 0.0 # Bonus armor penetration (бонус к пробитию брони)

# Special effect tag (например "incendiary", "armor_piercing", "explosive")
# (тег специального эффекта, например "поджог", "бронебойный", "взрывной")
@export var special_effect: String = ""
