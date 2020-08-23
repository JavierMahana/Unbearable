/// Int para el oso
global.HP = 3;
vidas = 3;
///Idle; 1 Mira a la derecha, 0 mira a la izquierda
idle = 1;
escalar = false;
//velocidades
spd = 2;
jumpforce = 15;
climbJumpForce = 8;
verSpd = 0;
gravityForce = 1;
maxVerSpd = 15;

onGround = false;

rollspd = 0;
///invencibilidad para el personaje si recibio daño recientemente
global.invencibilidad = false;
///ataque
global.atacando = false;
framesMelee = 8;
framesRoll = 20;
contadorAtaque = 0;
roll = false;
global.melee = false;
///checkpoints
checkpoint1 = false;