// pause
if (obj_controller.game_pause) exit;

if (place_meeting(x, y, Player)) {
    Player.player_damage()
    instance_destroy(); // destrói a maçã
}

image_angle += 10;