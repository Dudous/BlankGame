
// Life - Hearts
var space = 50;
var margin = 10;

for (var i=0; i<max_life; i++)
{
	if (i<=life-1)
	{
		draw_sprite(sprt_fullHeart, 0, margin + i*space, margin);
	}
	else
	{
		draw_sprite(sprt_emptHeart, 0, margin + i*space, margin);
	}
}


// CoolBar
var darkBlue_color = make_color_rgb(36, 36, 54);
var lightBlue_color = make_color_rgb(30, 30, 190);
var lightGreen_color = make_colour_rgb(180, 50, 50);

var percentCooldown = (cooldown / cooldown_max) * 100;
draw_healthbar(10, 90, 255, 60, percentCooldown, darkBlue_color, lightBlue_color, lightBlue_color, 0, true, true);
