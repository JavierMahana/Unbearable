global.win = false;

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
global.roll = false;
global.melee = false;
global.ataqueizquierda = false;
global.ataquederecha = false;
///miel
miel = 0;
///checkpoints
checkpoint = false;
checkpointtime = false;
///tiempos
time = 0;
timecheck = 0;
timestore = get_timer()/1000000;