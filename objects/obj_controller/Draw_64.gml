if (!game_pause) exit;

var middle_x = display_get_gui_width()/2;
var middle_y = display_get_gui_height()/2;

// fundo preto
draw_set_alpha(0.6);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_alpha(1);

draw_sprite(sprt_pause, 0, middle_x, middle_y);

draw_sprite_ext(sprt_play, 0, middle_x, middle_y-70, 0.4, 0.4, 0, c_white, 1);
draw_sprite_ext(sprt_quit, 0, middle_x, middle_y+100, 0.4, 0.4, 0, c_white, 1);



// posição do mouse
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// clique do mouse
if (mouse_check_button_pressed(mb_left))
{
	if (point_in_rectangle(
        mx, my,
        middle_x - sprite_get_width(sprt_play)*0.4/2,
        (middle_y - 70) - sprite_get_height(sprt_play)*0.4/2,
        middle_x + sprite_get_width(sprt_play)*0.4/2,
        (middle_y - 70) + sprite_get_height(sprt_play)*0.4/2))
	{
        game_pause = false;
    }
	
	if (point_in_rectangle(
        mx, my,
        middle_x - sprite_get_width(sprt_quit)*0.4/2,
        (middle_y + 100) - sprite_get_height(sprt_quit)*0.4/2,
        middle_x + sprite_get_width(sprt_quit)*0.4/2,
        (middle_y + 100) + sprite_get_height(sprt_quit)*0.4/2)) 
	{
		game_pause = !game_pause;
		Player.player_death();
    }
}




