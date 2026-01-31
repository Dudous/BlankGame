
if (obj_controller.game_pause)
{
	destroy();
}
else
{
	window_set_cursor(cr_none);
	x = mouse_x;
	y = mouse_y;
}

function destroy()
{
	window_set_cursor(cr_default);
	instance_destroy();
}