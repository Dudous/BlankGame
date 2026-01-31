if (keyboard_check_pressed(vk_escape))
{
	if (room != GameMenu)
	{
		obj_controller.game_pause = !game_pause;
	}
}
