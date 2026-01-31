if (place_meeting(x, y, obj_char)) {
    obj_char.player_damage()
    instance_destroy(); // destrói a maçã
}

image_angle += 10;