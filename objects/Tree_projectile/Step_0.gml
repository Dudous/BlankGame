if (place_meeting(x, y, obj_char)) {
    obj_char.player_damage()
    instance_destroy(); // destrói a maçã
}

gesture_rotate_angle(gesture_get_rotate_angle() + 35) 