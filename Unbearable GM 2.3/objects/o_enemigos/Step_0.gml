///Colision y daño al Jugador
if (instance_place(x,y,o_jugador) && !global.atacando)
{
	global.HP --;
	global.invencibilidad = true;
}
if path_position = 1
{
	image_xscale = -1	
}
if path_position = 0
{
	image_xscale = 1	
}
///Ser atacado por el jugador
if ManejarAtaques()
{
	instance_destroy(self,false);
}