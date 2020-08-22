//lo mismo que el horizontal pero manejando las coordenadas de y
function ManejarColisionesVerticales(colliders, deltaY)
{
	posY = y + deltaY;
	dirY = sign(posY - y);
	
	
	
	while(place_meeting(x, posY, colliders))
	{
		posY += -dirY;
	}
	
	
	//colObj = instance_place(x, posY, colliders);
	//if(colObj != noone)
	//{
	//	dirY = -sign(colObj.y - posY); 
		
	//	while(place_meeting(x, posY, colliders))
	//	{
	//		posY += -dirY;
	//	}
	//}
	
	return posY;
}

