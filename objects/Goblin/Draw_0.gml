draw_self()

if(_current_state == "attack")
{
	draw_sprite_ext(goblin_sprite_atk_hitboxes, image_index, x, y, image_xscale, image_yscale, 0, c_white, 0.5)	
}