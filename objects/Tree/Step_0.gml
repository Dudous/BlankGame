// verifica se o jogador está no alcance
if collision_circle(x, y, spot_range, obj_char, false, true) {
    is_hostil = true;
} else {
    is_hostil = false;
}

// contador de tempo
if (shoot_timer > 0) {
    shoot_timer--;
}

// atira só quando o tempo acabar
if (is_hostil && shoot_timer <= 0) {
    var apple = instance_create_layer(x + 30, y + 75, "Instances", Tree_projectile);

    var dir = point_direction(x + 30, y + 75, obj_char.x, obj_char.y);
    apple.direction = dir;
    apple.speed = 8;

    // reinicia o tempo do tiro
    shoot_timer = shoot_delay;
}