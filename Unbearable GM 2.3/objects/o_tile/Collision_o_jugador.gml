/// Todos los objetos pertenecientes a la matriz de o_tile comparten sus propiedades
///CUANDO HAY COLISION ENTRE O_TILE Y O_JUGADOR

if(instance_place(x,bbox_top,o_jugador))
{
	global.jump = false;
	show_debug_message("BOTTOM");
}
/*
if(instance_place(bbox_left, y, o_jugador) || instance_place(bbox_right, y, o_jugador))
{
	global.jump = false;
	global.spd = 0;
	show_debug_message("SIDES");
}

