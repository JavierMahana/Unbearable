/// ROLL
if (!global.melee && !roll)
{
	global.atacando = true;
	roll = true;
	sprite_index = s_roll;	
	if(idle==1 || Input_right)
	{
		image_xscale = 1;
		rollspd += 3;
	}
	if(idle==0 || Input_left)
	{
		image_xscale = -1;
		rollspd -= 3;
	}
}