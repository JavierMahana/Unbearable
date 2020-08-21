///RECIBE DAÑO DEL JUGADOR
if(global.atacando)
{
    if((instance_place(bbox_right, y, o_jugador) && (idle = 0 || Input_right)) )
	{
			show_debug_message("Punched! from the right");			
	}
	if((instance_place(bbox_left, y, o_jugador) && (idle = 1 || Input_left)) )
	{
			show_debug_message("Punched! from the left");			
	}
	
}
