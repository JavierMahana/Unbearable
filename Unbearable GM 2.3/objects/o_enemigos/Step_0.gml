///Colision y daño al Jugador
if (instance_place(x,y,o_jugador) and not global.atacando and not global.invencibilidad)
{
	global.HP --;
	global.invencibilidad = true;
}
if(not instance_place(x,y,o_jugador))
{
	global.invencibilidad = false;
}
///Ser atacado por el jugador
if ManejarAtaques()
{
	instance_destroy(self, true);
}

///REVISA LA ORIENTACION DEL SPRITE DEPENDIENDO SI TERMINO EL RECORRIDO DE SU RUTA
if path_position = 1
{
	image_xscale = -1	
}
if path_position = 0
{
	image_xscale = 1	
}
