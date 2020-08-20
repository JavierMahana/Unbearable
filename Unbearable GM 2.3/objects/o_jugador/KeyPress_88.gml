/// Ataque Con maleta
///SPRITE ATAQUE(NO FUNCIONA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
 
sprite_index = s_attack;	
if(idle==1 || Input_right)
{
	image_xscale = 1;
}
if(idle==0 || Input_left)
{
	image_xscale = -1;
}