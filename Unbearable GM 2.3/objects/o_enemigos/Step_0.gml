///Colision y daño al Jugador
if (instance_place(x,y,o_jugador) and not global.atacando and not global.invencibilidad)
{
	global.HP --;
	global.invencibilidad = true;
	audio_play_sound(sfx_ouch,100,false);
}

///Ser atacado por el jugador
if ManejarAtaques()
{
	audio_play_sound(sfx_enemydeath1 ,100,false);
	audio_play_sound(sfx_enemydeath2 ,100,false);
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
