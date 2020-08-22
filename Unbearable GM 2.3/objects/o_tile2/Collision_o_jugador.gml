/// Todos los objetos pertenecientes a la matriz de o_tile comparten sus propiedades
///CUANDO HAY COLISION ENTRE O_TILE Y O_JUGADOR

if(instance_place(x,bbox_top,o_jugador))
{
	global.gravedad = 0;
	global.jump = false;
}

//LADO IZQUIERDO
if(instance_place(bbox_left,y,o_jugador) && global.atacando)
{
	show_debug_message("ROLL POR LADO IZQUIERDO!");
	if(global.melee && instance_place(x+32,y,o_jugador) )
	{
		show_debug_message("MELEE POR LADO IZQUIERDO!");
	}	
}
//LADO DERECHO
if(instance_place(bbox_right,y,o_jugador) && global.atacando)
{
	show_debug_message("ROLL POR LADO DERECHO!");
	if(global.melee && instance_place(x-32,y,o_jugador) )
	{
		show_debug_message("MELEE POR LADO DERECHO!");
	}	
}

