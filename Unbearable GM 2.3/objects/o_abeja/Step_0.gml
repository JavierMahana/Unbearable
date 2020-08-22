if (instance_place(x,y,o_jugador) && !global.atacando)
{
	global.HP --;
	global.invencibilidad = true;
}