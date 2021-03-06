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

if(!global.roll)
{
	x = ManejarColisionesHorizontales(o_tile, MoveX);
}
///ESCALAR
if ( (Input_up && place_meeting(x, bbox_top, o_climb)) || (Input_down && place_meeting(x, bbox_bottom+1, o_climb)) )
{
	escalar = true;
}

if (escalar)
{
	MoveY = (Input_down  - Input_up )* spd;
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

//osea esta bajando
if(verSpd > 0)
{
	//esta arriba y no dentro de una plataforma.
	if(place_meeting(x,y + 1,o_tile2) && !place_meeting(x,y,o_tile2))
	{
		onGround = true;
	}
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
		audio_play_sound(sfx_jump ,100,false);
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

//y = ColisionesConPlataformasDeUnLado(o_tile2, verSpd + MoveY);
newY = ManejarColisionesVerticales(o_tile, verSpd + MoveY);
if(verSpd > 0 && !escalar)
{
	if(! place_meeting(x,y, o_tile2) && place_meeting(x, newY, o_tile2))
	{
		newY = ManejarColisionesVerticales(o_tile2, newY - y);
	}
}
y = newY;


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
			global.ataquederecha = false;
			global.ataqueizquierda = false;
			contadorAtaque = 0;
		}
	}	
	///ROLL
	
	if(global.roll)
	{
		image_speed = 0.8;
		contadorAtaque++;
		//x += rollspd;
		
		x = ManejarColisionesHorizontales(o_tile, rollspd);
		if(contadorAtaque >= framesRoll)
		{
			global.atacando = false;
			global.roll = false;
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
if (Input_space && !onGround && !global.atacando)
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

if(not instance_place(x,y,o_enemigos))
{
	global.invencibilidad = false;
}


#endregion

///MORIR
if (global.HP <= 0 or y > 900) 
{
    if not checkpoint
	{
		vidas --;
		x = o_start.x;
		y = o_start.y;
		global.HP = 3;
		timestore = get_timer()/1000000;
	}
	if checkpoint
	{
		vidas --;
		x = o_checkpoint.x;
		y = o_checkpoint.y;
		global.HP = 3;
		timestore = get_timer()/1000000;
		checkpointtime = true;

	}
	show_debug_message(vidas);
}
if (vidas <= 0) 
{
	room_restart();
}

///ACTUALIZAR CHECKPOINT
if place_meeting(x,y,o_checkpoint) and not checkpoint
{
	checkpoint = true;	
	timecheck = time;
	audio_play_sound(sfx_checkpoint ,100,false);
}

///GANAR
if(global.win)
{
	global.win = false;
	room_restart();
}

//TIEMPO
time =  get_timer()/1000000 - timestore;

if global.invencibilidad
{	
	sprite_index = s_ouch;
	if(idle==1 || Input_right)
	{
		image_xscale = 1;
	}
	if(idle==0 || Input_left)
	{
		image_xscale = -1;
	}
}
