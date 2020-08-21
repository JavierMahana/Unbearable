/// Ataque Con maleta
///SPRITE ATAQUE(NO FUNCIONA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!)
 
 show_debug_message("Se ha apretado x");
 
atacando = true;
sprite_index = s_attack;	
if(idle==1 || Input_right)
{
	image_xscale = 1;
}
if(idle==0 || Input_left)
{
	image_xscale = -1;
}