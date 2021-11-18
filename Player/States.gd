extends Node
class_name States

onready var Player = get_node("../../")
onready var AnimatedSprite = get_node("../../AnimatedSprite")

enum states { IDLE, RUN, JUMP, FALL, ATTACK1, ATTACK2, ATTACK3, CROUCH, SLIDE, DASH, HURT, DIE }
