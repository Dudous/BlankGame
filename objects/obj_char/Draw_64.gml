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