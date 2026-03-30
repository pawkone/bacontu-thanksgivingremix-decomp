if (buffer == 0)
{
    getMenu_input();
    var m = menus[currentmenu];
    var opt = m.options;
    var _length = array_length(opt) - 1;
    var q = opt[selected];
    BGX--;
    BGY--;
    
    if (q.type != optionstype.element_slider)
        move = key_left2 + key_right2;
    else
        move = key_left + key_right;
    
    if (move != 0 && q.type != optionstype.element_button && q.type != optionstype.element_bind)
    {
        q.val += move;
        q.val = clamp(q.val, 0, q.max);
        q.func();
        
        if (q.type != optionstype.element_slider)
            FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect");
    }
    
    var _oSelect = selected;
    var _move2 = key_down2 - key_up2;
    
    if (_move2 != 0 && changingBind == false)
    {
        selected += _move2;
        selected = clamp(selected, 0, _length);
        
        if (selected != _oSelect)
            FMODevent_oneshot("event:/Sfx/UI/Pause/step");
    }
    
    if (key_slap2 && q.selecting == false && changingBind == false)
    {
        m.backfunc();
        FMODevent_oneshot("event:/Sfx/UI/Pause/menuback");
    }
    
    if (q.type != optionstype.element_bind && q.type != optionstype.element_slider)
    {
        if (key_jump2)
        {
            FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect");
            
            if (q.type != optionstype.element_button)
            {
                q.val += 1;
                q.val = wrap(q.val, 0, q.max);
            }
            
            q.func();
        }
    }
    
    if (q.type == optionstype.element_slider)
    {
        if (move != 0)
        {
            q.moving = true;
            
            if (currentmenu == 1)
                fmod_studio_event_instance_set_paused(screamSnd, false);
            
            if (!FMODevent_isplaying(screamSnd))
                fmod_studio_event_instance_start(screamSnd);
            
            fmod_studio_event_instance_set_volume(screamSnd, (q.val / 100) * global.MasterVolume);
        }
        else
        {
            q.moving = false;
            fmod_studio_event_instance_set_paused(screamSnd, true);
        }
    }
    
    if (q.type != optionstype.element_slider)
        fmod_studio_event_instance_set_paused(screamSnd, true);
    
    if (currentmenu == 6)
    {
        if (keyboard_check_pressed(vk_f1) && changingBind == false)
            reset_input();
        
        if (q.type == optionstype.element_bind)
        {
            if (!changingBind)
            {
                if (key_jump2)
                    changingBind = true;
                else if (key_taunt2)
                    variable_struct_set(global.inputMap, q.key, []);
            }
            else if (keyboard_check_pressed(vk_anykey))
            {
                draw_set_font(global.npcfont);
                var keyboardKey = variable_struct_get(global.inputMap, q.key);
                
                if (!array_contains(keyboardKey, keyboard_key) && (string_width(string_upper(chr(keyboard_key))) > 0 || keyboard_key == vk_up || keyboard_key == vk_down || keyboard_key == vk_left || keyboard_key == vk_right || keyboard_key == vk_escape || keyboard_key == vk_shift || keyboard_key == vk_space || keyboard_key == vk_control))
                {
                    array_push(variable_struct_get(global.inputMap, q.key), keyboard_key);
                    changingBind = false;
                }
            }
        }
    }
    
    if (currentmenu == 8)
    {
        if (keyboard_check_pressed(vk_f1) && changingBind == false)
            reset_input();
        
        if (q.type == optionstype.element_bind)
        {
            if (!changingBind)
            {
                if (key_jump2)
                    changingBind = true;
                else if (key_taunt2)
                    array_set(variable_struct_get(global.inputMap, q.key), 1, []);
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_face1))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32769);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_face2))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32770);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_face3))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32771);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderlb))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32775);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderrb))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32776);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderl))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32773);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_shoulderr))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32774);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_face4))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32772);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_padu))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32781);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_padd))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32782);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_padl))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32783);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_padr))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32784);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_stickl))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32779);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_stickr))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32780);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_start))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32778);
                changingBind = false;
                q.func();
            }
            else if (gamepad_button_check_pressed(global.gamepadCurrent, gp_select))
            {
                array_push(variable_struct_get(global.inputMap, q.key), 32777);
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axislh) < -global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyLL");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axislh) > global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyLR");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axislv) < -global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyLU");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axislv) > global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyLD");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axisrh) < -global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyRL");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axisrh) > global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyRR");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axisrv) < -global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyRU");
                changingBind = false;
                q.func();
            }
            else if (gamepad_axis_value(global.gamepadCurrent, gp_axisrv) > global.gamepadDeadzones.general)
            {
                array_push(variable_struct_get(global.inputMap, q.key), "joyRD");
                changingBind = false;
                q.func();
            }
        }
    }
}

buffer = approach(buffer, 0, 1);
