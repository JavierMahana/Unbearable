/// Controles del Oso
/// TECLAS DE INPUT ///

Input_left = keyboard_check(vk_left);
Input_right = keyboard_check(vk_right);
Input_up = keyboard_check(vk_up);
Input_down = keyboard_check(vk_down);
input_run = keyboard_check(vk_shift);
Input_space = keyboard_check(vk_space);
//input_debug = keyboard_check_pressed(vk_enter);
//DEBUGS

#region MOVIMIENTOS

/// PARA ESTABLECER LA POSICION DEL JUGADOR ///

MoveX = 0;
MoveY = 0;

/// MOVIMIENTO ///

///CORRER O CAMINAR

if (input_run)
{
	spd = 5;
	image_speed = 2;
}
else 
{
	spd = 2.5;
	image_speed = 1;
}

MoveX = ( Input_right  - Input_left ) * spd;

x = ManejarColisionesHorizontales(o_tile, MoveX);

///ESCALAR
if ( (Input_up && place_meeting(x, bbox_top, o_climb)) || (Input_down && place_meeting(x, bbox_bottom+1, o_climb)) )
{
	escalar = true;
}

if (escalar)
{
	MoveY = (Input_down  - Input_up )* spd;
	if(global.jump)
	{
		global.jump = false;
	}	
}

if(!place_meeting(x, y, o_climb))
{
	escalar = false;
}


//antes de todo esto hay q arreglar la colision horizontal.
onGround = false;


if(place_meeting(x,y + 1,o_tile) || escalar)
{
	onGround = true;
	//show_debug_message("en el piso!");
}



if(onGround && Input_space)
{
	if(escalar)
	{
		verSpd = -climbJumpForce;
	}
	else
	{
		verSpd = -jumpforce;
	}
	
	onGround = false;
}

if(!onGround)
{
	verSpd += gravityForce;
	if(verSpd > maxVerSpd)
	{
		verSpd = maxVerSpd;
	}
	else if(verSpd < -maxVerSpd)
	{
		verSpd = -maxVerSpd;
	}
}
else
{
	verSpd = 0;
}

posY = ManejarColisionesVerticales(o_tile, verSpd + MoveY);
///SALTO
//if (Input_space && !global.jump)
//{
//	global.jump = true;
//}

//if (global.jump && Input_space)
//{
//	MoveY += -spd * 2;	
//}

//if(!place_meeting(x,bbox_bottom,o_tile) && !escalar)
//{
//	global.gravedad += 0.5;
//}


//ATAQUES
if(global.atacando)
{
	///MALETA
	if(global.melee)
	{
		contadorAtaque++;
		if(contadorAtaque >= framesMelee)
		{
			global.atacando = false;
			global.melee = false;
			contadorAtaque = 0;
		}
	}	
	///ROLL
	if(roll)
	{
		image_speed = 0.8;
		contadorAtaque++;
		x += rollspd;
		if(contadorAtaque >= framesRoll)
		{
			global.atacando = false;
			roll = false;
			rollspd = 0;
			contadorAtaque = 0;
			
		}
	}	
	
}

/// SE ACTUALIZAN LOS SPRITES ///
#region Sprites Para movimientos

 ///SPRITES PARA CAMINAR
if(spd && MoveX != 0 && !global.atacando && !escalar)
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
if(!Input_up && !Input_left && !Input_right && !Input_space && !global.atacando && !escalar)
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
if(    (place_meeting(x, y, o_climb)) &&  (Input_up || Input_down) && !global.atacando)
{
	sprite_index = s_climb;	
	image_speed = 2;
}
if(place_meeting(x, y, o_climb) && escalar && (!Input_up && !Input_down))
{
	sprite_index = s_climb;	
	image_speed = 0;
}
 

 ///SPRITE AL SALTAR
if (Input_space && global.jump && !global.atacando)
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

/// ACTUALIZAR LA POSICION DEL OBJETO ///
if(!global.atacando)
{
	//x += MoveX;
	y = posY;//MoveY 
	//if(!escalar)
	//{
	//	y += global.gravedad;
	//}
}



#endregion

///MORIR
if(global.HP <= 0 and vidas > 1)
{
	vidas --;
	x = o_checkpoint.x;
	y = o_checkpoint.y;
	global.HP = 3;
}
else if(global.HP <= 0)
{
	room_restart();
}

///ACTUALIZAR CHECKPOINT
//Primer checkpoint
if(x > 700 and checkpoint1 == false)
{
	o_checkpoint.x = x;
	o_checkpoint.y = y;
	checkpoint1 = true;
}