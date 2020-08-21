/// Controles del Oso
/// TECLAS DE INPUT ///

Input_left = keyboard_check(vk_left);
Input_right = keyboard_check(vk_right);
Input_up = keyboard_check(vk_up);
Input_down = keyboard_check(vk_down);
input_run = keyboard_check(vk_shift);
Input_space = keyboard_check(vk_space);
input_debug = keyboard_check_pressed(vk_enter);
//DEBUGS
if (input_debug)
{
	show_debug_message(phy_linear_velocity_y );
}



#region MOVIMIENTOS

/// PARA ESTABLECER LA POSICION DEL JUGADOR ///

MoveX = 0;
MoveY = 0;


/// MOVIMIENTO ///

///CORRER O CAMINAR

if (input_run)// && !global.jump)
{
	global.spd = 4;

}
else 
{
	global.spd = 2;
}

MoveX = ( Input_right  - Input_left ) * global.spd;

///ESCALAR
if (Input_up || Input_down)
{
	if(place_meeting(x, y + Input_down, o_climb))
    {
		MoveY = (Input_down  - Input_up )* global.spd;
		if(global.jump)
		{
			global.jump = false;
		}
		phy_linear_velocity_y = 0;
		global.spd = 0;
	}	
}

///SALTO
if (Input_space && !global.jump)
{
	global.jump = true;
}

if (global.jump)
{
	if (global.spd>=4)
	{
		global.spd = 2.5;
	}
	global.spd *= 2.5;
	MoveY = -global.spd;	
}





//manejo de ataque
if(atacando)
{
	contadorAtaque++;
	if(contadorAtaque >= framesDeAtaque)
	{
		atacando = false;
		contadorAtaque = 0;
	}
}



/// SE ACTUALIZAN LOS SPRITES Y LUEGO LA POSICION ///
#region Sprites Para movimientos

 ///SPRITES PARA CAMINAR
if(global.spd && MoveX != 0 && !atacando)
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
if(!Input_up && !Input_left && !Input_right && !Input_space && !atacando)
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
if(    (place_meeting(x, y - 2, o_climb) || place_meeting(x, y + 2, o_climb)) &&  (Input_up || Input_down) && !atacando)
{
	sprite_index = s_climb;	
}
 
 
 ///SPRITE RODAR


 ///SPRITE AL SALTAR
if (Input_space && global.jump && !atacando)
{
	sprite_index = s_jump;	
	if(idle==1 || Input_right)
	{
		image_xscale = 1;
	}
	if(idle==0 || Input_left)
	{
		image_xscale = -1;
	}
}

#endregion

///ACTUALIZAR LAS COORDENADAS DEL OBJETO
phy_position_x += MoveX;
phy_position_y += MoveY;
///ACTUALIZAR LA POSICION DEL OBJETO
phy_fixed_rotation = 1;


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

