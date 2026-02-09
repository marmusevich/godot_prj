class_name CommonEnums extends Resource


# ------------------------------------------------------------
## Damage type (тип урона)
enum DamageType {
	## Kinetic (кинетический)
	KINETIC,
	## Energy (энергетический)
	ENERGY,
	## Thermal (термический)
	THERMAL
}

# ------------------------------------------------------------
## Platforms (платформы/носители)
enum Platform {
	## Infantry (пехота)
	INFANTRY,
	## Drones
	DRONE,
	## Vehicles (колёсная/гусеничная техника)
	VEHICLE
}

# ------------------------------------------------------------
## Armor hit side (стороны попадания)
enum HitSide {
	FRONT,
	BACK,
	LEFT,
	RIGHT
}

# ------------------------------------------------------------
## Weapon categories (категории оружия)
enum WeaponCategory {
    ## Melee weapon / рукопашное (нож, дубинка)
	MELEE,
	## Firearms / дальнобойное(пистолет, автомат)
	FIREARM,
	## Thrown / бросаемое(гранаты)
	THROWN
}

# ------------------------------------------------------------
## Weapon handling (одна/две руки)
enum Handling {
    ## One-handed (одноручное)
	ONE_HANDED,
	## Two-handed (двухручное)
	TWO_HANDED
}
