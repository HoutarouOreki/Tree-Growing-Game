class_name Player extends CharacterBody3D

var disabled: bool = false

@onready var itemRay: RayCast3D = $Neck/Camera3D/ItemRay
@onready var dayCycle: AnimationPlayer = $DayCycle
