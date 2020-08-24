/// Vida

draw_sprite(s_corazon, 0, 0,0);
if(global.HP >= 2)
{
	draw_sprite(s_corazon, 0, 40,0);
}
if(global.HP >= 3)
{
	draw_sprite(s_corazon, 0, 80,0);
}
/// Tiempo
draw_set_font(Fuente);
draw_set_color(c_black);
draw_text(600,0,"Tiempo");

if o_jugador.checkpointtime {draw_text(700,0, o_jugador.time + o_jugador.timecheck);}
else {draw_text(700,0, o_jugador.time);}

/// Vidas
draw_text(600,20,"Vidas");
draw_text(700,20, o_jugador.vidas);

///Miel
draw_text(600,40,"Miel");
draw_text(700,40, string(o_jugador.miel) + "/5");
