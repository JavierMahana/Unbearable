///MELEE
/// Ataque Con maleta 
if (!global.melee && !roll)
{
	global.atacando = true;
	global.melee = true;
	sprite_index = s_attack;	
	if(idle==1 || Input_right)
	{
		image_xscale = 1;
		
	}
	if(idle==0 || Input_left)
	{
		image_xscale = -1;
	}
}