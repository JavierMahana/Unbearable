

//retorna la posicion en x en la cual el objeto ya no esta chocando con el colider.
//deltaX es la cantidad de movimiento de x a la posicion deseada.
function ManejarColisionesHorizontales(colliders, deltaX)
{
	posX = x + deltaX;
	
	colObj = instance_place(posX, y, colliders);
	if(colObj != noone)
	{
		dirX = -sign(colObj.x - posX); 
		
		while(place_meeting(posX, y, colliders))
		{
			posX += dirX;
		}
	}
	
	return posX;
}