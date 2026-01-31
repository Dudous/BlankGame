
// movement
var _xinput = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var _yinput = keyboard_check(ord("S")) - keyboard_check(ord("W"));

move_and_collide(_xinput * my_speed, _yinput * my_speed, obj_wall);


// green attack
if (mouse_check_button_pressed(mb_left) and cooldown <= 0)
{
    instance_create_layer(mouse_x, mouse_y, "Instances", obj_greenAttack);
	cooldown = 5;
}


// red attack
if (keyboard_check(ord("E")) and cooldown <= 0)
{
	instance_create_layer(x, y, "Instances", obj_redAttack);
	obj_redAttack.image_angle = point_direction(x, y, mouse_x, mouse_y);
	cooldown = 5;
}

// blue attack
if (keyboard_check(ord("F")) and cooldown <= 0)
{
	instance_create_layer(x, y, "Instances", obj_blueAttack);
	cooldown = 5;
}


//cooldown
cooldown -= delta_time / 500000;