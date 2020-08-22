// Ataques
function ManejarAtaques()
{
	if(global.atacando)
	{
		///retorna verdadero por la voltereta oo golpe con X
		if( instance_place(x,y,o_jugador) || (instance_place(x,y,o_jugador) && global.melee) ) 
		{
			return true;
		}
		return false;	
	}
}
