/// @description Inserte aquí la descripción
// Puede escribir su código en este editor

draw_sprite(s_corazon, 0, 0,0);
if(global.HP >= 2)
{
	draw_sprite(s_corazon, 0, 40,0);
}
if(global.HP >= 3)
{
	draw_sprite(s_corazon, 0, 80,0);
}