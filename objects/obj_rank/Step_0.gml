depth = obj_player.depth + 5;
shake = approach(shake, 0, 1);
fadeAlpha = approach(fadeAlpha, 1, 0.1);
get_input();

with (obj_player)
{
    hsp = 0;
    vsp = 0;
    image_speed = 0.35;
    var targetx = obj_screensizer.displayWidth / 2;
    var targety = obj_screensizer.displayHeight / 2;
    var point = point_direction(obj_player.x, obj_player.y, targetx, targety);
    var lx = lengthdir_x(2, point);
    var ly = lengthdir_y(2, point);
    x = approach(x, targetx, abs(lx));
    y = approach(y, targety, abs(ly));
    
    if (animation_end())
        image_speed = 0;
}

ranktimer = approach(ranktimer, 0, 1);

switch (cutscenePart)
{
    case 0:
        if (fadeAlpha == 1)
        {
            showRank = false;
            ranktimer = 300;
            cutscenePart++;
            
            with (obj_player)
            {
                x -= camera_get_view_x(view_camera[0]);
                y -= camera_get_view_y(view_camera[0]);
                x = floor(x);
                y = floor(y);
            }
            
            room = rank_room;
        }
        
        break;
    
    case 1:
        if (!showRank && ranktimer == 0)
        {
            showRank = true;
            rankIndex = 0;
            obj_player.visible = false;
            ranktimer = 300;
        }
        else
        {
            rankIndex += 0.5;
            rankIndex = clamp(rankIndex, 0, sprite_get_number(rankspr) - 1);
            
            if (rankIndex == (sprite_get_number(rankspr) - 1) && showRank)
                showRankText = true;
            
            if (ranktimer == 0)
            {
                cutscenePart++;
                alarm[0] = 40;
            }
        }
        
        break;
    
    case 2:
        break;
}

if (canContinue)
{
    if (key_jump2)
    {
        with (obj_player)
        {
            generalReset();
            movespeed = 0;
            vsp = 0;
            hsp = 0;
            state = states.enterdoor;
            visible = true;
        }
        
        room_goto(avocadoMenu);
        global.level = -4;
        global.resetRoom = -4;
        fmod_studio_event_instance_stop(music, states.crouch);
        instance_destroy();
    }
}
