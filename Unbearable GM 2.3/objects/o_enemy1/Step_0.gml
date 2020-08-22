/// @description Inserte aquí la descripción

///Darse la vuelta
if(instance_place(x, y, o_turningpoint) and enemy1vuelta == true){enemy1vuelta = false;}
else if(instance_place(x, y, o_turningpoint) and enemy1vuelta == false){enemy1vuelta = true;}

///Moverse
if(enemy1vuelta == true)
{
	x += enemy1speed;
	image_xscale = 1;
}
else if(enemy1vuelta == false)
{
	x += -enemy1speed;
	image_xscale = -1;
}

///Dañar al Jugador
if(instance_place(x, y, o_jugador) and global.invencibilidad == false)
{
	global.HP --;
	global.invencibilidad = true;
}
else if(not instance_place(x, y, o_jugador) and global.invencibilidad == true)
{
	global.invencibilidad = false;
}


///A mimir zzzz
if((instance_place(x+30, y, o_jugador) or(instance_place(x-30, y, o_jugador))) and global.atacando)
{
	instance_deactivate_object(self);
}