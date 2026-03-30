if (hitstun.is == false)
{
    event_inherited();
    
    switch (state)
    {
        case states.stun:
            scr_enemy_stun();
            break;
        
        case states.hit:
            scr_enemy_hit();
            break;
        
        case states.turn:
            scr_enemy_turn();
            break;
        
        case states.move:
            scr_enemy_move();
            break;
        
        case states.grab:
            scr_enemy_grabbed();
            break;
        
        case states.thrown:
            scr_enemy_thrown();
            break;
    }
}
else if (hitstun.time >= 0)
{
    image_speed = 0;
    x = hitstun.x + irandom_range(-5, 5);
    y = hitstun.y + irandom_range(-5, 5);
    hitstun.time--;
}
else
{
    x = hitstun.x;
    y = hitstun.y;
    hitstun.is = false;
}
