class_name PlayerAnimator
extends AnimatedSprite2D

var facing_dir := 'left'

var anims: Dictionary = {
	"idle" = "",
	"idle_reverse" = "",
	"walking" = "",
	"shooting" = "",
	"dying" = ""
}

func _ready():
	if(owner.player == Enums.Players.PLAYER_2):
		facing_dir = 'right'
		
	var reverse_dir = 'left' if facing_dir == 'right' else 'right'
		
	anims['idle'] = str('idle_', facing_dir)
	anims['walking'] = str('walking_', facing_dir)
	anims['idle_reverse'] = str('idle_', reverse_dir)
	anims['shooting'] = str('shooting_', reverse_dir)
	anims['dying'] = str('dying_', facing_dir)
	
	animation_finished.connect(_on_anim_finished)
		
	go_idle()
		
func go_idle(reverse: bool = false):
	var anim_name: String = anims['idle_reverse'] if reverse else anims['idle']
	self.play(anim_name)

func turn_around():
	go_idle(true)

func start_walking():
	var anim_name: String = anims['walking']
	self.play(anim_name)
	
func stop_walking():
	go_idle()
	
func play_shooting():
	var anim_name: String = anims['shooting']
	self.stop()
	self.play(anim_name)
	
func _on_anim_finished():
	go_idle(true)
