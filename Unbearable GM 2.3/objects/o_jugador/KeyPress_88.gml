///MELEE
/// Ataque Con maleta 
if (!global.melee && !global.roll)
{
	global.atacando = true;
	global.melee = true;
	sprite_index = s_attack;	
	if(idle==1 || Input_right)
	{
		image_xscale = 1;
		global.ataquederecha = true;
		
	}
	if(idle==0 || Input_left)
	{
		image_xscale = -1;
		global.ataqueizquierda = true;
	}
}