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
if path_position = 1
{
	image_xscale = -1	
}
if path_position = 0
{
	image_xscale = 1	
}
///Ser atacado por el jugador
if (ManejarAtaques() or instance_place(x, y-34, o_jugador))
{
	instance_destroy(self,false);
}