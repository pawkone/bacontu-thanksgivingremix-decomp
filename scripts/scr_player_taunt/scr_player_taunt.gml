function scr_player_taunt()
{
    hsp = 0;
    vsp = 0;
    get_input();
    image_speed = 0;
    tauntTimer--;
    
    if (tauntTimer <= 0)
    {
        state = tauntVars.state;
        sprite_index = tauntVars.sprite_index;
        image_index = tauntVars.image_index;
        vsp = tauntVars.vsp;
        hsp = tauntVars.hsp;
        movespeed = tauntVars.movespeed;
        image_speed = tauntVars.image_speed;
    }
}
