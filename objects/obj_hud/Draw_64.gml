if (!ds_list_empty(collectVis))
{
    for (var i = 0; i < ds_list_size(collectVis); i++)
    {
        var q = ds_list_find_value(collectVis, i);
        
        with (q)
            draw_sprite_ext(sprite_index, 4, x, y, 1, 1, 0, c_white, 1);
    }
}

with (kettle)
{
    draw_sprite(spr_kettleScore, 0, kx, ky);
    draw_set_font(global.kettleFont);
    draw_set_halign(fa_center);
    draw_text(kx + 16, ky - 4, global.collect);
    var rankindex = 0;
    
    if (global.collect >= global.Srank)
        rankindex = 4;
    else if (global.collect >= global.Arank)
        rankindex = 3;
    else if (global.collect >= global.Brank)
        rankindex = 2;
    else if (global.collect >= global.Crank)
        rankindex = 1;
    
    if (previousRank != rankindex)
    {
        previousRank = rankindex;
        rankScale = 2;
    }
    
    var rankX = x + (sin(current_time * 0.001) * 2);
    var rankY = y + (cos(current_time * 0.001) * 2);
    draw_sprite(spr_kettleCloud1, cloudIndex, rankX + 121, mean(rankY, ky) - 54);
    draw_sprite(spr_kettleCloud2, cloudIndex, rankX + 154, rankY - 46);
    draw_sprite(spr_kettleCloud3, cloudIndex, rankX + 160, rankY);
    draw_sprite_ext(spr_hudRanks, rankindex, rankX + 160, rankY, rankScale, rankScale, 0, c_white, 1);
    var perc = 0;
    
    switch (rankindex)
    {
        case 5:
            perc = 1;
            break;
        
        case 4:
            perc = 0;
            break;
        
        case 3:
            perc = (global.collect - global.Arank) / (global.Srank - global.Arank);
            break;
        
        case 2:
            perc = (global.collect - global.Brank) / (global.Arank - global.Brank);
            break;
        
        case 1:
            perc = (global.collect - global.Crank) / (global.Brank - global.Crank);
            break;
        
        default:
            perc = global.collect / global.Crank;
            break;
    }
    
    var amt = sprite_get_height(spr_hudRanksFill) * perc;
    var top = sprite_get_height(spr_hudRanksFill) - amt;
    var xo = sprite_get_xoffset(spr_hudRanksFill);
    var yo = sprite_get_yoffset(spr_hudRanksFill);
    draw_sprite_part_ext(spr_hudRanksFill, rankindex, 0, top, sprite_get_width(spr_hudRanksFill), sprite_get_height(spr_hudRanksFill) - top, (rankX + 160) - xo, (rankY - yo) + top, rankScale, rankScale, c_white, 1);
}

with (combometer)
{
    var _perc = global.combo.timer / 60;
    
    if (state == -1)
    {
        if (global.combo.dropped && !instance_exists(obj_fallingvase) && !vasedestroyed)
        {
            vaseoffset = 330;
            vasedestroyed = true;
            instance_create_depth(x - 100, y - 21, other.depth - 1, obj_fallingvase);
        }
        
        x = 811 + wave(-5, 5, 3, 0);
        y = approach(y, -128, 5);
        
        if (global.combo.amt > 0)
        {
            state = 0;
            vsp = 15;
        }
    }
    else if (state == 0)
    {
        vasedestroyed = false;
        x = 811 + wave(-5, 5, 3, 0);
        vsp += 0.5;
        y += vsp;
        
        if (y > 245)
            state = 1;
    }
    else if (state == 1)
    {
        if (_perc <= 0.5 && _perc > 0.2)
        {
            x = 811 + wave(-5, 5, 3, 0) + irandom_range(-2, 2);
            vsp += 0.3;
            y += vsp;
            
            if (y > 237)
            {
                y = 237;
                vsp = -2;
            }
        }
        else if (_perc <= 0.2)
        {
            x = 811 + wave(-5, 5, 3, 0) + irandom_range(-5, 5);
            vsp += 0.3;
            y += vsp;
            
            if (y > 237)
            {
                y = 237;
                vsp = -4;
            }
        }
        else
        {
            x = 811 + wave(-5, 5, 3, 0);
            y = lerp(y, 237, 0.1);
        }
        
        if (global.combo.amt == 0)
            state = -1;
    }
    
    draw_sprite(spr_combo_table, 0, x, y);
    catvsp += 0.2;
    caty += catvsp;
    
    if (caty > y)
    {
        caty = y;
        catvsp = -4;
        y += 6;
    }
    
    draw_sprite(spr_combo_vase, global.combo.dropped, (x - 100) + vaseoffset, y - 21);
    catx = lerp(catx, (x - 40) + (128 * _perc), 0.15);
    draw_sprite(spr_combo_cat, 0, catx, caty);
    draw_set_font(global.comboFont);
    draw_set_halign(fa_right);
    draw_text(x - 12, y + 40, global.combo.amt);
    vaseoffset = approach(vaseoffset, 0, 15);
}

with (tv)
{
    if (sprite_index != spr_tv_turnon)
        draw_sprite(spr_tv_bg, 0, x, y);
    
    pal_swap_set(obj_player.spr_palette, obj_player.palIndex, false);
    draw_sprite(sprite_index, image_index, x, y);
    shader_reset();
    pattern_draw(sprite_index, image_index, x, y, 1, 1, 0, 16777215, 1, global.patternSpr, spr_playerPatColors);
    
    if (state == states.move)
        draw_sprite(spr_tv_switch, switchindex, x, y);
}

draw_set_font(global.smallfont);
draw_set_color(c_white);
draw_set_halign(fa_right);
var _xx = obj_screensizer.displayWidth - 32;
var _yy = obj_screensizer.displayHeight - 32;
global.save_timer++;

if (global.level != -4)
    global.level_timer++;

draw_text(_xx, _yy, calculateTime(global.save_timer));
draw_text(_xx, _yy - 16, calculateTime(global.level_timer));
