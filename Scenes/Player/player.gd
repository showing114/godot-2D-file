extends CharacterBody2D;

@onready var player_sprite: Sprite2D = %PlayerSprite
@onready var walk_animation_player: AnimationPlayer = $WalkAnimationPlayer
@onready var walk_audio_stream_player: AudioStreamPlayer = $WalkAudioStreamPlayer
@onready var jump_animation_player: AnimationPlayer = $JumpAnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var anchor: Node2D = $Anchor
@onready var walk_gpu_particles_2d: GPUParticles2D = $WalkGPUParticles2D
@onready var jump_gpu_particles_2d: GPUParticles2D = $JumpGPUParticles2D
#@onready var back_sound_stream_player: AudioStreamPlayer = $"../BackSoundStreamPlayer"
const _1 = preload("uid://c5wd28uee3fbo")

#用ctrl+鼠标拖动节点增加节点的引用

#const JUMP_VELOCITY = -400.0;和const SPEED = 300.0; 将值定义在gamemanager里方便全局读取并修改
var jumping : bool = true;
#jump表示玩家是否处于可继续下落的状态
var jumping_timer : float = 0.0;

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (jumping):
		jumping_timer += delta;#delta表示上一帧与这一帧的时间差
		jump_gpu_particles_2d.emitting = (jumping_timer <= 0.15);
		if(is_on_floor()):
			#这里表示跳跃之后的落地检测 并实时修改jumping的值
			jumping = false;
			jump_animation_player.play("End") 
	else :
		#处于不可下落时 判断跳跃 并在跳跃之后将jumping设为true
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			audio_stream_player.play();
			velocity.y = GameManager.JUMP_VELOCITY;
			jump_animation_player.play("Start");
			jumping = true;
			jumping_timer = 0.0;
	if not is_on_floor():
		velocity += get_gravity() * delta;
		#给角色施加重力

	var direction := Input.get_axis("ui_left", "ui_right");
	#判断输入情况 用Input.get_axis(检测-1的值的键,检测1的值的键)
	if (direction > 0):
		player_sprite.flip_h=false;
	elif (direction < 0):
		player_sprite.flip_h=true;
	if direction:
		#非0即有按下键为真 为0为假
		velocity.x = direction * GameManager.SPEED;
		if(is_on_floor()):
			walk_animation_player.play("walk");
			#用paly函数播放动画 动画用字符串形式
			walk_gpu_particles_2d.emitting = true;
			if(! walk_audio_stream_player.playing):
				walk_audio_stream_player.play();
				pass;
		else : 
			walk_gpu_particles_2d.emitting = false;
		anchor.rotation_degrees =lerp(anchor.rotation_degrees, direction * 7.0, 0.05);
		#lerp(角度1,角度2,每次旋转的角度)函数 用于计算线性角度的旋转 它是浮点型函数 所以数值只能用小数形式(?)
	else:
		velocity.x = move_toward(velocity.x, 0, GameManager.SPEED);
		walk_animation_player.stop();
		anchor.rotation_degrees =lerp(anchor.rotation_degrees, 0.0, 0.2);
		walk_gpu_particles_2d.emitting = false;
	move_and_slide()
func _ready():
	add_to_group("Player");
