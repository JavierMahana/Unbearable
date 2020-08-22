/// Todos los objetos pertenecientes a la matriz de o_tile comparten sus propiedades
///CUANDO HAY COLISION ENTRE O_TILE Y O_JUGADOR
///Los ifs son para que se pueda avanzar por este tile desde abajo
if(instance_place(x,bbox_top-5,o_jugador))
{
	global.gravedad = 0;
	global.jump = false;
	show_debug_message("NO CAE");
}
else
{
	show_debug_message("CAE");
}