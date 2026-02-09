class_name ArmorDefinition extends BaseDefinition

# ============================================================
# ENUMS
# ============================================================

## слот брони
enum ArmorSlot {
	## Head slot (шлем)
	HEAD,
	## Body / torso
	BODY,
	## Legs
	LEGS,
	## Full body (скафандр, экзоскелет)
	FULL_BODY
}


# ============================================================
# CLASSIFICATION
# ============================================================

## слот брони
@export var slot: ArmorSlot
## можно установить на платформы
@export var allowed_platforms: Array[CommonEnums.Platform]


# ============================================================
# ARMOR PROTECTION
# ============================================================
## защита по сторонам и типам урона, armor[HitSide][DamageType] = value
@export var armor := {
	CommonEnums.HitSide.FRONT: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	},
	CommonEnums.HitSide.BACK: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	},
	CommonEnums.HitSide.LEFT: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	},
	CommonEnums.HitSide.RIGHT: {
		CommonEnums.DamageType.KINETIC: 0.0,
		CommonEnums.DamageType.ENERGY: 0.0,
		CommonEnums.DamageType.THERMAL: 0.0
	}
}

## Ricochet chance (вероятность рикошета)
@export var ricochet_chance: float = 0.0

# ============================================================
# ENVIRONMENTAL
# ============================================================

# Sealed suit (герметичность)
@export var sealed: bool = false
# Radiation resist (опц.)
@export var radiation_resistance: float = 0.0

# ============================================================
# SUPPORT / AUGMENTATION
# ============================================================

## Carry capacity bonus (бонус к грузоподъёмности — экзоскелет)
@export var carry_capacity_bonus: float = 0.0

# ============================================================
# DURABILITY
# ============================================================

## Base durability (базовая прочность)
@export var base_durability: float = 1.0  

# ============================================================
# HELPERS
# ============================================================

func supports_platform(platform: CommonEnums.Platform) -> bool:
	return platform in allowed_platforms

func armor_value(side: CommonEnums.HitSide, damage_type: CommonEnums.DamageType) -> float:
	return armor.get(side, {}).get(damage_type, 0.0)
