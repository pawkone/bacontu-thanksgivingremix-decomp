draw_set_color(c_white);
draw_sprite_tiled_ext(spr_optionsBG, 0, BGX, BGY, 1, 1, c_white, 1);

for (var i = 0; i < array_length(backgrounds); i++)
{
    draw_sprite_tiled_ext(spr_optionsBG, backgrounds[i].index, BGX, BGY, 1, 1, c_white, backgrounds[i].alpha);
    
    if (backgrounds[i].menu != [optionstype.mainpage])
    {
        var _alpha = 0;
        
        for (var q = 0; q < array_length(backgrounds[i].menu); q++)
        {
            if (currentmenu == backgrounds[i].menu[q])
                _alpha = 1;
        }
        
        backgrounds[i].alpha = approach(backgrounds[i].alpha, _alpha, 0.1);
    }
    else
    {
        backgrounds[i].alpha = 1;
    }
}

var m = menus[currentmenu];
var opt = m.options;
var _length = array_length(opt);

switch (m.anchor)
{
    case optionstype.anchor_center:
        var xx = obj_screensizer.displayWidth / 2;
        var yy = (obj_screensizer.displayHeight / 2) - ((m.ypad * _length) / 2);
        
        for (var i = 0; i < _length; i++)
        {
            var q = opt[i];
            var _col = (selected == i) ? 16777215 : 8421504;
            draw_set_font(global.bigfont);
            draw_set_color(_col);
            draw_set_halign(fa_center);
            draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
            
            if (is_struct(q.icon))
            {
                draw_set_alpha(q.icon.alpha);
                draw_sprite(spr_pauseicons, q.icon.index, floor((xx + irandom_range(-1, 1)) - (string_width(lang_get_phrase(q.name)) / 2) - 50), floor(yy + (m.ypad * i) + irandom_range(-1, 1)));
                draw_set_alpha(1);
                q.icon.alpha = approach(q.icon.alpha, selected == i, 0.1);
            }
        }
        
        break;
    
    case optionstype.anchor_left:
        var xx = obj_screensizer.displayWidth / 5;
        var yy = (obj_screensizer.displayHeight / 2) - ((m.ypad * _length) / 2);
        
        for (var i = 0; i < _length; i++)
        {
            draw_set_font(global.bigfont);
            var _col = (selected == i) ? 16777215 : 8421504;
            draw_set_color(_col);
            var q = opt[i];
            
            switch (q.type)
            {
                case optionstype.element_button:
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    break;
                
                case optionstype.element_toggle:
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    draw_set_halign(fa_right);
                    draw_textEX(obj_screensizer.displayWidth - xx, yy + (m.ypad * i), lang_get_phrase(q.toggle[q.val]));
                    break;
                
                case optionstype.element_slider:
                    if (selected != i && q.moving)
                        q.moving = false;
                    
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    draw_set_halign(fa_right);
                    draw_sprite(spr_slider, 0, obj_screensizer.displayWidth - xx - 150, yy + (m.ypad * i));
                    draw_sprite((currentmenu != 1) ? spr_slidericon2 : spr_slidericon, q.moving, (obj_screensizer.displayWidth - xx - 150) + (200 * (q.val / 100)), yy + (m.ypad * i) + 12);
                    break;
            }
        }
        
        break;
    
    case optionstype.anchor_controls:
        draw_set_halign(fa_left);
        draw_sprite(spr_tutorialkey, 0, 56, (obj_screensizer.displayHeight - 192) + 2);
        draw_set_color(c_black);
        draw_set_font(global.npcfont);
        draw_set_halign(fa_left);
        draw_text(59, obj_screensizer.displayHeight - 192 - 6, "F1");
        draw_set_color(c_white);
        draw_set_font(global.creditsfont);
        draw_textEX(64, obj_screensizer.displayHeight - 128, lang_get_phrase("option_add_bind"));
        draw_text(128, obj_screensizer.displayHeight - 192, lang_get_phrase("option_reset_binds"));
        draw_textEX(64, obj_screensizer.displayHeight - 64, lang_get_phrase("option_clear_binds"));
        
        for (var i = 0; i < _length; i++)
        {
            draw_set_font(global.bigfont);
            var _col = (selected == i) ? 16777215 : 8421504;
            draw_set_color(_col);
            var q = opt[i];
            
            switch (q.type)
            {
                case optionstype.element_button:
                    var xx = obj_screensizer.displayWidth / 5;
                    var yy = 16 + m.ypad;
                    draw_set_halign(fa_left);
                    draw_textEX(xx, yy + (m.ypad * i), lang_get_phrase(q.name));
                    break;
                
                case optionstype.element_bind:
                    var xx = (obj_screensizer.displayWidth / 2) - 16;
                    var yy = (16 + m.ypad) - keyScroll;
                    draw_set_color(_col);
                    keyScroll = lerp(keyScroll, 48 * (selected - 1), 0.02);
                    
                    if (!is_string(q.iconIndex))
                    {
                        draw_sprite_ext(spr_controlicons, q.iconIndex, xx, yy + (m.ypad * i), 1, 1, 0, _col, 1);
                    }
                    else
                    {
                        draw_set_font(global.bigfont);
                        draw_set_halign(fa_left);
                        draw_textEX(xx - 16, yy + (m.ypad * i), q.iconIndex);
                    }
                    
                    draw_set_halign(fa_right);
                    
                    for (var p = 0; p < array_length(variable_struct_get(global.inputMap, q.key)); p++)
                    {
                        if (currentmenu == 6)
                        {
                            switch (array_get(variable_struct_get(global.inputMap, q.key), p))
                            {
                                case 37:
                                    draw_sprite(spr_tutorialkeyspecial, 6, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 40:
                                    draw_sprite(spr_tutorialkeyspecial, 4, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 38:
                                    draw_sprite(spr_tutorialkeyspecial, 3, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 39:
                                    draw_sprite(spr_tutorialkeyspecial, 5, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32:
                                    draw_sprite(spr_tutorialkeyspecial, 2, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 17:
                                    draw_sprite(spr_tutorialkeyspecial, 1, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 27:
                                    draw_sprite(spr_tutorialkeyspecial, 7, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 16:
                                    draw_sprite(spr_tutorialkeyspecial, 0, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                default:
                                    draw_sprite(spr_tutorialkey, 0, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    draw_set_color(c_black);
                                    draw_set_font(global.npcfont);
                                    draw_set_halign(fa_left);
                                    draw_text(obj_screensizer.displayWidth - 64 - (42 * p), (yy + (m.ypad * i)) - 6, chr(array_get(variable_struct_get(global.inputMap, q.key), p)));
                                    break;
                            }
                        }
                        
                        if (currentmenu == 8)
                        {
                            switch (array_get(variable_struct_get(global.inputMap, q.key), p))
                            {
                                case 32769:
                                    draw_sprite(global.buttonSpr, 0, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32770:
                                    draw_sprite(global.buttonSpr, 1, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32771:
                                    draw_sprite(global.buttonSpr, 2, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32772:
                                    draw_sprite(global.buttonSpr, 3, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32773:
                                    draw_sprite(global.buttonSpr, 4, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32774:
                                    draw_sprite(global.buttonSpr, 5, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32776:
                                    draw_sprite(global.buttonSpr, 6, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32775:
                                    draw_sprite(global.buttonSpr, 7, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32779:
                                    draw_sprite(global.buttonSpr, 8, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32780:
                                    draw_sprite(global.buttonSpr, 9, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32781:
                                    draw_sprite(global.buttonSpr, 10, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32784:
                                    draw_sprite(global.buttonSpr, 11, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32782:
                                    draw_sprite(global.buttonSpr, 12, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32783:
                                    draw_sprite(global.buttonSpr, 13, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32778:
                                    draw_sprite(global.buttonSpr, 14, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case 32777:
                                    draw_sprite(global.buttonSpr, 15, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLL":
                                    draw_sprite(global.joystickSpr, 0, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLR":
                                    draw_sprite(global.joystickSpr, 1, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLU":
                                    draw_sprite(global.joystickSpr, 2, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyLD":
                                    draw_sprite(global.joystickSpr, 3, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRL":
                                    draw_sprite(global.joystickSpr, 4, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRR":
                                    draw_sprite(global.joystickSpr, 5, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRU":
                                    draw_sprite(global.joystickSpr, 6, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                                
                                case "joyRD":
                                    draw_sprite(global.joystickSpr, 7, obj_screensizer.displayWidth - 64 - (42 * p) - 8, yy + (m.ypad * i) + 2);
                                    break;
                            }
                        }
                    }
                    
                    break;
            }
        }
        
        break;
}

draw_set_color(c_white);

if (changingBind)
{
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_textEX(obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2, "PRESS ANY KEY");
}
