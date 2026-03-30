switch (scene)
{
    case 0:
        randomEventTimer = 60;
        
        with (obj_player)
        {
            state = -4;
            vsp = -7;
            hsp = 7;
            sprite_index = spr_player_spinout;
            image_index = 0;
            image_speed = 0.35;
            xscale = 1;
        }
        
        with (inst_100851)
            sprite_index = spr_milton;
        
        scene++;
        break;
    
    case 1:
        with (inst_100851)
        {
            x = approach(x, obj_player.x + 192, 12);
            
            if (x != obj_player.x)
                image_xscale = sign(obj_player.x - x);
        }
        
        with (obj_player)
        {
            if (grounded && sprite_index == spr_player_spinout)
            {
                hsp = 0;
                sprite_index = spr_player_beakerintro;
                image_index = 0;
            }
            
            if (sprite_index == spr_player_beakerintro)
            {
                if (animation_end())
                    image_index = image_number - 1;
                
                if (inst_100851.x == (obj_player.x + 192))
                    other.scene++;
            }
        }
        
        break;
    
    case 2:
        randomEventTimer--;
        
        if (randomEventTimer <= 0)
        {
            music = FMODevent_oneshot("event:/Music/Cutscene/rivalry");
            scene++;
            
            with (obj_dialog)
            {
                textVisual = "";
                textLetter = 1;
                active = true;
                alarm[0] = 2;
            }
        }
        
        break;
    
    case 3:
        with (obj_player)
        {
            if (sprite_index == spr_player_beakerintro)
            {
                if (animation_end())
                    image_index = image_number - 1;
            }
        }
        
        if (!instance_exists(obj_dialog))
        {
            fmod_studio_event_instance_stop(music, states.crouch);
            
            with (inst_100851)
            {
                instance_destroy();
                
                repeat (10)
                    create_particleStatic(spr_genericpoofeffect, x + irandom_range(25, -25), y + irandom_range(25, -25), 1);
            }
            
            instance_destroy();
            
            with (obj_player)
            {
                jumpBuffer = 0;
                vsp = -4;
                hsp = -8;
                movespeed = -8;
                state = states.jump;
            }
            
            obj_music.pauseMusic = false;
        }
        
        break;
}
