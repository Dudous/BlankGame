// pause
if (obj_controller.game_pause) exit;


// movement
var _xinput = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _yinput = keyboard_check(ord("S")) - keyboard_check(ord("W"));

move_and_collide(_xinput * my_speed, _yinput * my_speed, obj_wall);


// green attack
if (mouse_check_button_pressed(mb_left) and cooldown >= cooldown_max and instance_exists(obj_aim))
{
    instance_create_layer(mouse_x, mouse_y, "Instances", obj_greenAttack);
	cooldown = 0;
}


// red attack
if (keyboard_check(ord("E")) and cooldown >= cooldown_max)
{
	instance_create_layer(x, y, "Instances", obj_redAttack);
	obj_redAttack.image_angle = point_direction(x, y, mouse_x, mouse_y);
	cooldown = 0;
}

// blue attack
if (keyboard_check(ord("F")) and cooldown >= cooldown_max)
{
	instance_create_layer(x, y, "Instances", obj_blueAttack);
	cooldown = 0;
}


// cooldown
cooldown += delta_time / 500000;


// life
function player_damage()
{
    life--;
	if(life<=0)
	{
		player_death()
	}
}

function player_heal()
{
	if(life<max_life)
	{
		life++;
	}
}

function player_death()
{
	room_goto(GameMenu);
	with (all) {
		instance_destroy();
	}
}







// Exemplo de dano
if (keyboard_check_pressed(ord("P")))
{
	player_damage()
}

// Iniciar Mascara Verde
if (keyboard_check_pressed(ord("L")))
{
	if (!instance_exists(obj_aim))
	{
		instance_create_layer(mouse_x, mouse_y, "Aim", obj_aim);
	}
	else
	{
		obj_aim.destroy();
	}
}




