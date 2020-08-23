// Ataques
function ManejarAtaques()
{
	if global.atacando
	{
		///retorna verdadero por la voltereta "C"
		if instance_place(x,y,o_jugador) and global.roll {return true;}
		///retorna verdadero por ataque con maleta "X"
		if global.melee
		{
			if (instance_place(bbox_right,y,o_jugador) and global.ataqueizquierda){return true;}
			if (instance_place(bbox_left,y,o_jugador) and global.ataquederecha){return true;}
		}
	}
	///retorna true si toca la parte inferior del jugador y no la superior "SALTO"
	if instance_place(x, bbox_top, o_jugador) and 
	   not instance_place(x, bbox_bottom, o_jugador) {return true;}   

	///de lo contrario no hay conexion con el ataque
	return false;	
}