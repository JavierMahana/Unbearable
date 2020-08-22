/// Objeto de Salud
if(instance_place(x, y, o_jugador))
{
	if(global.HP<3){global.HP ++;}
	instance_deactivate_object(self);
}
if(up)
{
	cont++;
	y += 0.025*cont;
	if(cont == 10)
	{
		up = false;
		cont = 0;
	}
}
if(!up)
{
	cont++
	y -= 0.025*cont;
	if(cont==10)
	{
		up = true;
		cont = 0;
	}
}