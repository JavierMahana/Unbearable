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


/// SE ACTUALIZAN LOS SPRITES Y LUEGO LA POSICION ///
#region Sprites Para movimientos

 ///SPRITES PARA CAMINAR
if(global.spd && MoveX != 0)
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
if(!Input_up && !Input_left && !Input_right && !Input_space)
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
if(    (place_meeting(x, y - 2, o_climb) || place_meeting(x, y + 2, o_climb)) &&  (Input_up || Input_down) )
{
	sprite_index = s_climb;	
}
 
 
 ///SPRITE RODAR


 ///SPRITE AL SALTAR
if (Input_space && global.jump )
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


#region codigo del profe.

/*

/// @description Inserte aquí la descripción
// Puede escribir su código en este editor

#region //Revisión del estado de teclado y del gamepad

//Reviso el estado de las teclas
tecla_derecha = keyboard_check(vk_right);
tecla_izquierda = keyboard_check(vk_left);
tecla_salto = keyboard_check_pressed(vk_space);
tecla_correr = keyboard_check(ord("A"));
tecla_empujar = keyboard_check(ord("S"));


//Reviso el etado del gamepad
//https://docs.yoyogames.com/source/dadiospice/002_reference/mouse,%20keyboard%20and%20other%20controls/gamepad%20input/index.html
gamepad_derecha = 0;
gamepad_izquierda = 0;
gamepad_salto = 0;
gamepad_correr = 0;
gamepad_empujar = 0;
if( gamepad_is_connected(gamepad_id) )
{
	
	//Calculo hacia qué dirección se debe mover
	//los valores fluctuan entre [-1, 1]
	//considerar que cada axis puede que no entregue 
	//cero cuando etá suelto, esto pasa por calibración
	//o por uso y desgaste
	var haxis = gamepad_axis_value(gamepad_id, gp_axislh);
	if( haxis > 0.2 )
	{
		gamepad_derecha = 1;
	}
	else if( haxis < -0.2 )
	{
		gamepad_izquierda = 1;
	}
	
	//saltar
	if( gamepad_button_check(gamepad_id, gp_face1) )
	{
		gamepad_salto = 1;
	}
	//correr
	if( gamepad_button_check(gamepad_id, gp_face3) )
	{
		gamepad_correr = 1;
	}
	
	//empujar
	if( gamepad_button_check(gamepad_id, gp_face2) )
	{
		gamepad_empujar = 1;
	}
	
}


//Calculo las variables para el jugador dependiendo del estado del gamepad y del teclado
player_derecha = 0;
if( tecla_derecha == 1 or gamepad_derecha == 1)
{
	player_derecha = 1;
}

player_izquierda = 0;
if( tecla_izquierda == 1 or gamepad_izquierda == 1)
{
	player_izquierda = 1;
}

player_saltar = 0;
if( tecla_salto == 1 or gamepad_salto == 1)
{
	player_saltar = 1;
}

player_correr = 0;
if( tecla_correr == 1 or gamepad_correr == 1 )
{
	player_correr = 1;
}

player_empujar = 0;
if( tecla_empujar == 1 or gamepad_empujar == 1 )
{
	player_empujar = 1;
}

#endregion

#region //Calculo las variables para movimiento

//las variables player_derecha y player_izquierda continenen un 0 o un 1
//dado que hacia la derecha van los valores positivos y hacia la izquierda 
//los valores negativos, realizo la resta. 
//En el caso que se presione el movimiento hacia la derecha e izquierda juntos
//el resultado será 0 y el personaje no se moverá
direccion = player_derecha - player_izquierda;

//asumo que los valores de velocidad por defecto toman los valores de caminar
velocidad_horizontal = velocidad_horizontal_caminar;
velocidad_sprite = velocidad_sprite_caminar;
//si se presionsó correr actualizo los valores
if( player_correr )
{
	velocidad_horizontal = velocidad_horizontal_correr;
	velocidad_sprite = velocidad_sprite_correr;
}
#endregion

#region //Calculo si puedo o no realizar el salto

//El salto debe ocurrir si estoy justo sobre un objeto oBlock o un objeto oPlatoform
//para ello, consulto si una unidad abajo se encuentran dichos objetos, en el caso
//en que no, la función instance_place devuelve el valor "noone" que significa nada
block_collide = instance_place(x, y + 1, oBlock);
platform_collide = instance_place(x, y + 1, oPlatform);


//El caso de los objetos oPlatform puede resultar complejo, estas plataformas son "one way",
//esto significa que solamente la cara superior está activa cuando el jugador va bajando.
//En el caso de este tipo de plataformas, algunas pueden estar contenidas dentro de otras,
//para ello debo buscar todas los objetos oPlarform 
platform_list = ds_list_create();
nplatforms = instance_place_list(x, y + 1, oPlatform, platform_list, false);

//el jugador puede saltar solamente si se encuentra en el suelo y si 
//abajo no hay nada o hay plataformas (objetos oPlatform)
if( player_saltar and (block_collide != noone or nplatforms > 0))
{
	//si estamos parados en un objeto oBlock saltamos
	if( platform_collide == noone or block_collide != noone)
	{
		velocidad_vertical = fuerza_salto;
	}
	else
	{
		//recorro todas las plataformas (oPlatform) y reviso si el borde inferior del bounding box 
		//del jugador se encuentra sobre el el borde superior del bounding box de la plataforma
		
		for (var i = 0; i < ncollides; ++i;)
		{
			//el operador pipe (|) vcollide_list[| i] se utiliza en el caso que en el arreglo se encuentren objetos
			//para los valores primitivos (como por ejemplo números enteros) no se utiliza
			platform_collide = vcollide_list[| i];
			if( platform_collide != noone and platform_collide.bbox_top > bbox_bottom )
			{
				velocidad_vertical = fuerza_salto;
			}
		}
	}
}

#endregion

#region //Actualización del sprite

//si se está moviendo, obtengo el signo de la dirección, resultando
//para la derecha 1 y para la izauierda -1
if( direccion != 0 )
{
	self.image_xscale = sign(direccion);
}

//si la velocidad vertical es distinto de 0 (será positivo cuando caiga
//y negativo cuiando suba) cambio el sprite por el de salto
if( velocidad_vertical != 0 )
{
	sprite_index = sPlayerJump;
}
else
{
	//en caso que no se encuentre con velocidad vertical, si la dirección es
	//distinto de cero (se encuentra caminando o corriendo), cambio el sprite
	//y le cambio la velocidad del sprite (cantidad de frames por segundo)
	if( direccion != 0 )
	{
		self.sprite_index = sPlayerWalk;
		self.image_speed = velocidad_sprite;
	}
	//si no se encuentra saltando ni moviendose cambio el sprite al sprite sin movimiento
	//hay que tener en cuenta que este sprite tiene solo un frame, por lo cual mantiene la 
	//velocidad del sprite de caminar y no afecta, si el sprite "idle" tuviera más de un frame
	//hay que cambiar dicha velocidad
	else
	{
		self.sprite_index = sPlayerIdle;
	}
}
#endregion

#region //Movimiento horizontal

//calculo cuanto se moverá en este paso, la variable "direccion" 
//tiene un 1 o -1 y define la dirección
delta_x = direccion*velocidad_horizontal;

//si se encuentra con un objeto oBlock no podrá avanzar todo
//lo planificado, por lo cual calculo cuanto puedo moverme.
hcollide = instance_place(x + delta_x, y, oBlock);

//si en la dirección del movimiento me encuentro con un bloque o una caja
if( hcollide != noone )
{
	//en el caso de los bloques y cajas me muevo unidad por unidad hasta que no quede espacio
	hcollide = instance_place(x + sign(delta_x), y, oBlock);
	while( hcollide == noone)
	{
		x += sign(delta_x);
		hcollide = instance_place(x + sign(delta_x), y, oBlock);
	}
	
	//Debo actualizar el sprite, ya que si hay una caja y se presionó la tecla empujar
	//o el botón empujar del gamepad debo mostrar el sprite caminar con una velocidad menor
	hcollide = instance_place(x + sign(direccion), y, oBox);
	if( hcollide != noone and player_empujar )
	{
		delta_x = sign(direccion);
		hcollide.x += delta_x;
		self.sprite_index = sPlayerWalk;
		self.image_speed = velocidad_sprite_empujar;
	}
	//no hay una caja, sino un muro, por lo cual muestro el sprite "idle"
	else
	{
		self.sprite_index = sPlayerIdle;
	}
}
//no hay nada adelante, por lo cual me muevo
else
{
	x += delta_x;
}

#endregion

#region //movimiento vertical

//en cada iteración cambio la velocidad vertical debido a la gravedad
velocidad_vertical += gravedad;

//la cantidad de unidades que se moveré en el eje Y es la velocidad actual
delta_y = velocidad_vertical;

//reviso si en chocará con un objeto oBlock, en este caso la velocidad deberá 
//resultar en cero. Tal colisión puede ocurrir porque estamos subiendo o bajando
vcollide = instance_place(x, y + delta_y, oBlock);

//si encontramos un ojeto 
if( vcollide != noone )
{
	//nos debemos mover unidad por unidad en la dirección que se encuentra 
	//el movimiento hata quedar una unidad antes
	vcollide = instance_place(x, y + sign(delta_y), oBlock);
	while( vcollide == noone )
	{
		y += sign(delta_y);
		vcollide = instance_place(x, y + sign(delta_y), oBlock);
	}
	//cambiamos a 0 lo que nos queda por mover y cambiamos la velocidad a 0
	delta_y = 0;
	velocidad_vertical = 0;
}



//para el caso de los objetos oPlatform, debemos detener el movimiento 
//solamente cuando nos movemos hacia abajo y el borde inferior del jugador
//choca con el borde superior de la plataforma

//obtenemos todas las instancias oPlatform que chocan con nuestro personaje
vcollide_list = ds_list_create();
ncollides = instance_place_list(x, y + delta_y, oPlatform, vcollide_list, false);

//si hay almenos una plataforma
if( ncollides > 0 )
{
	//recorremos todas las plataformas
	for (var i = 0; i < ncollides; ++i;)
	{
		//revisamos si el borde superior de la plataforma colisiona con
		//el borde inferior del jugador. En este caso dado que conocemos
		//el punto de origen de nuestros sprites (el central), calculamos
		//donde quedará el sprite y lo asignamos
		//(también funciona mover unidad por unidad como lo hicimos de forma horizontal)
		vcollide = vcollide_list[| i];
		if( delta_y >= 0 and vcollide.bbox_top > bbox_bottom )
		{
			y = vcollide.bbox_top - sprite_height/2;
			//ya que asignamos el lugar final nos dejamos de mover y cambiamos la velocidad a 0
			delta_y = 0;
			velocidad_vertical = 0;
		}
	}
}
//me muevo, no es necesario el "else", ya que si entramos al "if" cambiamos la cantidad a moverse a 0
y += delta_y;

#endregion






*/
#endregion