/// @description Inserte aquí la descripción
// Puede escribir su código en este editor


if(instance_place(x, y, o_jugador))
{
	if(global.HP<3){global.HP ++;}
	instance_deactivate_object(self);
}