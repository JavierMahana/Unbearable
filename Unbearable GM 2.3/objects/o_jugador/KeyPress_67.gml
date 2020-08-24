/// ROLL
if (!global.melee && !global.roll)
{
	audio_play_sound(sfx_roll ,100,false);
	global.atacando = true;
	global.roll = true;
	sprite_index = s_roll;	
	if(idle==1 || Input_right)
	{
		image_xscale = 1;
		rollspd += 6;
	}
	if(idle==0 || Input_left)
	{
		image_xscale = -1;
		rollspd -= 6;
	}
}