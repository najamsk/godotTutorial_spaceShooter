extends Node2D

@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var scale_component: ScaleComponent = $ScaleComponent
@onready var flash_component: FlashComponent = $FlashComponent

@onready var hitbox_component: HitboxComponent = $HitboxComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale_component.tween_scale()
	flash_component.flash()
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
#	hit_hurtbox takces one argument of type hurtbox and passing it to queue_free
#	which is not accepting any argument so we are unbinding that passed 
#	argument to make it work
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
