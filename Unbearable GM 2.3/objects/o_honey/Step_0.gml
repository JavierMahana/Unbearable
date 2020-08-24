/// Objeto de Salud
if(instance_place(x, y, o_jugador))
{
	if(global.HP<3){global.HP ++;}
	o_jugador.miel ++;
	audio_play_sound(sfx_eat ,100,false);
	instance_deactivate_object(self);
}
