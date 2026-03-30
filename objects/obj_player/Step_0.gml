if (key_jump2)
    jumpBuffer = 15;

if (key_slap2)
    slapBuffer = 15;

if (FMODevent_isplaying(soundsOk))
    FMODSet3dPos(soundsOk, x, y);

if (FMODevent_isplaying(soundsLaugh))
    FMODSet3dPos(soundsLaugh, x, y);

var _insta = state == states.mach3 || (state == states.machturn && sprite_index == spr_player_mach3turn) || state == states.superjump || state == states.uppercut || state == states.groundpound || state == states.groundpoundstart || state == states.buzzsaw;
instakill = _insta;

if (hitstun.is == false)
{
    if (!instance_exists(obj_technicaldifficulty))
        global.combo.timer = approach(global.combo.timer, 0, 0.15);
    
    if (global.combo.previouscombo != global.combo.amt)
    {
        global.combo.previouscombo = global.combo.amt;
        
        if (global.combo.amt > 0 && (global.combo.amt % 5) == 0)
        {
            instance_destroy(obj_comboTitle);
            
            with (instance_create_depth(811, 350, obj_hud.depth, obj_comboTitle))
                image_index = floor(global.combo.amt / 5);
            
            FMODevent_oneshot("event:/Sfx/UI/Combo/comboup");
        }
    }
    
    if (global.combo.timer == 0 && global.combo.amt > 0)
    {
        global.combo.savecombo = global.combo.amt;
        global.combo.amt = 0;
        global.combo.dropped = true;
        
        if (room != rank_room)
        {
            FMODevent_oneshot("event:/Sfx/UI/Combo/comboend");
            instance_destroy(obj_comboTitle);
            
            with (instance_create_depth(811, 350, obj_hud.depth, obj_comboTitle))
            {
                image_index = floor(global.combo.savecombo / 5);
                lostcombo = true;
            }
        }
    }
    
    scr_collision();
    scr_collide_destructibles();
    jumpBuffer = approach(jumpBuffer, 0, 1);
    slapBuffer = approach(slapBuffer, 0, 1);
    
    if (grounded)
        coyote_time = 10;
    else if (vsp < 0)
        coyote_time = 0;
    
    coyote_time--;
    
    if (state != states.hurt)
        i_frame = approach(i_frame, 0, 1);
    
    if (i_frame > 0 && state != states.hurt)
        image_alpha = round(wave(0, 1, 0.1, 0));
    else
        image_alpha = 1;
    
    if (state == states.walkfront)
        image_blend = make_colour_hsv(0, 0, (image_index / image_number) * 255);
    else
        image_blend = make_colour_hsv(0, 0, 255);
    
    if (flash == true && alarm[0] <= 0)
        alarm[0] = 5;
    
    if (y < -500 || y > (room_height + 500))
    {
        if (!instance_exists(obj_technicaldifficulty))
            instance_create_depth(x, y, -100, obj_technicaldifficulty);
    }
    
    switch (state)
    {
        case states.normal:
            scr_player_normal();
            break;
        
        case states.jump:
            scr_player_jump();
            break;
        
        case states.crouch:
            scr_player_crouch();
            break;
        
        case states.mach2:
            scr_player_mach2();
            break;
        
        case states.machslide:
            scr_player_machslide();
            break;
        
        case states.mach3:
            scr_player_mach3();
            break;
        
        case states.machturn:
            scr_player_machturn();
            break;
        
        case states.hitwall:
            scr_player_hitwall();
            break;
        
        case states.superjumpprep:
            scr_player_superjumpprep();
            break;
        
        case states.superjump:
            scr_player_superjump();
            break;
        
        case states.freefallland:
            scr_player_freefallland();
            break;
        
        case states.taunt:
            scr_player_taunt();
            break;
        
        case states.tumble:
            scr_player_tumble();
            break;
        
        case states.climbwall:
            scr_player_climbwall();
            break;
        
        case states.groundpound:
            scr_player_groundpound();
            break;
        
        case states.groundpoundstart:
            scr_player_groundpoundstart();
            break;
        
        case states.enterdoor:
            scr_player_enterdoor();
            break;
        
        case states.grab:
            scr_player_grab();
            break;
        
        case states.hauling:
            scr_player_hauling();
            break;
        
        case states.finishingblow:
            scr_player_finishingblow();
            break;
        
        case states.uppercut:
            scr_player_uppercut();
            break;
        
        case states.hurt:
            scr_player_hurt();
            break;
        
        case states.ladder:
            scr_player_ladder();
            break;
        
        case states.buzzsaw:
            scr_player_buzzsaw();
            break;
        
        case states.walkfront:
            scr_player_walkfront();
            break;
        
        case states.parry:
            scr_player_parry();
            break;
        
        case states.surfing:
            scr_player_surfing();
            break;
        
        case states.diveboard:
            scr_player_diveboard();
            break;
        
        case states.ski:
            scr_player_ski();
            break;
        
        case states.skibounce:
            scr_player_skibounce();
            break;
        
        case states.skirow:
            scr_player_skirow();
            break;
    }
    
    if (state == states.crouch || state == states.tumble || state == states.superjumpprep)
        mask_index = spr_crouchmask;
    else
        mask_index = spr_player_mask;
}
else
{
    get_input();
    
    if (hitstun.time >= 0)
    {
        image_speed = 0;
        x = hitstun.x + irandom_range(-5, 5);
        y = hitstun.y + irandom_range(-5, 5);
        hitstun.time--;
        
        if (instance_exists(obj_fadeout))
        {
            hitstun.time = 0;
            x = hitstun.x;
            y = hitstun.y;
            hitstun.is = false;
        }
    }
    else
    {
        x = hitstun.x;
        y = hitstun.y;
        hitstun.is = false;
    }
}
