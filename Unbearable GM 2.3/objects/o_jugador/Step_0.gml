/// Controles del Oso
/// TECLAS DE INPUT ///

Input_left = keyboard_check(vk_left);
Input_right = keyboard_check(vk_right);
Input_up = keyboard_check(vk_up);
Input_down = keyboard_check(vk_down);
input_run = keyboard_check(vk_shift);

#region MOVIMIENTOS

/// PARA ESTABLECER LA POSICION DEL JUGADOR ///

MoveX = 0;
MoveY = 0;
spd = 0;

/// MOVIMIENTO ///

///CORRER O CAMINAR
if (input_run)
{
	spd = 4;
}
else
{
	spd = 2;
}

// En GMS 2, las declaraciones bool true or false equivalen a 1 o 0 respectivamente
// En caso de querer tener siempre un resultado positivo, usar "abs" que entrega el absoluto de un valor.

MoveX = ( Input_right  - Input_left ) * spd;


/// SE ACTUALIZAN LOS SPRITES Y LUEGO LA POSICION ///
#region Sprites Para movimientos

 ///SPRITES PARA CAMINAR
 if (spd && MoveX != 0)
 {
	 sprite_index = s_walk;
	 if(MoveX > 0)
	 {
		 image_xscale = 1;
		 idle = 1;
	 }
	 else
	 {
		 image_xscale = -1;
		 idle = 0;
	 }
	 
 }
 ///SPIRTES AL ESTAR QUIETO
 if(!Input_left && !Input_right)
 {
	 sprite_index = s_idle;	
	 if(idle = 0)
	 {
		 image_xscale = -1;
	 }
	 else
	 {
		 image_xscale = 1;
	 }
	 
 }
 ///SPRITE ESCALAR
 
 
 ///SPRITE ATAQUE
 
 
 ///SPRITE RODAR
	 

#endregion

x += MoveX;
y += MoveY;

#endregion


////////////////////////////////////////////////////////////////////////
//COLISIONES PRECISAS
#region
/*

/// REVISAR COLISIONES CON MUROS ///

//sign devuelve el valor 1 o 0 de MoveX
if(place_meeting( x+MoveX, y, obj_wall)) && (MoveX!=0) // Colision Horizontal
{
	repeat(abs(MoveX)) //Repite mientras el valor de MoveX sea absoluto
	{
		//Si aún no hay colision en x + sign
		//sign es el valor del bool MoveX; 0 o 1;
		//Si aun no hay colision suma 1, hasta que haya, en cuyo caso hace break
		if(!place_meeting( x+sign(MoveX), y, obj_wall))
		{
			x+=sign(MoveX)
		}
		else
		{
			break;
		}
	}
	
	MoveX = 0;
}

if(place_meeting( x, y+MoveY, obj_wall)) && (MoveY!=0) // Colision Vertical
{
	repeat(abs(MoveY)) //Repite mientras el valor de MoveY sea absoluto
	{
		//Si aún no hay colision en y + sign
		//sign es el valor del bool MoveY; 0 o 1;
		//Si aun no hay colision suma 1, hasta que haya, en cuyo caso hace break
		if(!place_meeting( x, y+sign(MoveY), obj_wall)) 
		{
			y+=sign(MoveY)
		}
		else
		{
			break;
		}
	}
	
	MoveY = 0;
}


*/
#endregion
