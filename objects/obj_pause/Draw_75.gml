if (!instance_exists(obj_option))
{
    if (active)
    {
        shader_set(shd_wave);
        shader_set_uniform_f(timeUniform, waveTime);
        waveTime++;
        shader_set_uniform_f(frequencyUniform, freq);
        shader_set_uniform_f(amplitudeUniform, amp);
        draw_sprite(screenSprite, 0, 0, 0);
        shader_reset();
        draw_set_alpha(graphBack.alpha);
        draw_set_color(c_black);
        draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
        draw_set_color(c_white);
        draw_sprite_ext(spr_disc, disc.index, obj_screensizer.displayWidth - 50, obj_screensizer.displayHeight - 50, abs(disc.xscale), 1, disc.rotation, c_white, graphBack.alpha / 0.55);
        draw_set_alpha(1);
    }
    
    var xx = obj_screensizer.displayWidth - 300;
    var yy = (obj_screensizer.displayHeight / 2) - (80 * ((array_length(options) - 1) / 2));
    
    for (var i = 0; i < array_length(options); i++)
    {
        var q = options[i];
        
        if (!active)
            q.offsetX = lerp(q.offsetX, obj_screensizer.displayWidth, 0.15);
        else if (selected == i)
            q.offsetX = lerp(q.offsetX, -15, 0.15);
        else
            q.offsetX = lerp(q.offsetX, 0, 0.15);
        
        if (is_struct(q))
        {
            draw_sprite(spr_pauseSelectBacon, selected != i, xx + q.offsetX, yy + (80 * i));
            draw_set_font(global.bigfont);
            draw_set_color((selected == i) ? c_white : c_gray);
            draw_set_halign(fa_center);
            draw_textEX(xx + q.offsetX, (yy + (80 * i)) - 24, lang_get_phrase(q.option));
        }
    }
    
    with (bacon)
    {
        draw_sprite(spr_pauseBaconNormal, index, round(x), round(y));
        pattern_draw(spr_pauseBaconNormal, 0, round(x), round(y), 1, 1, 0, 16777215, 1, global.patternSpr, spr_playerPatColors, other.playerPalSprite, other.playerPalIndex);
        draw_sprite(spr_pauseBaconSmokeNormal, smokeIndex, x + 174, y - 99);
        var _interpX = 0.2;
        var _interpY = 0.2;
        
        if (other.active)
            _interpY = 0.1;
        
        if (other.active)
            _interpX = 0.05;
        
        x = lerp(x, other.active ? 208 : -224, _interpX);
        y = lerp(y, other.active ? 343 : 672, _interpY);
        smokeIndex += 0.1;
    }
    
    draw_sprite_ext(spr_pauseBorder, 0, obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2, graphBorderSize, graphBorderSize, 0, c_white, 1);
    graphBorderSize = lerp(graphBorderSize, active ? 1 : 2, 0.15);
    
    if (active)
    {
        draw_set_font(global.smallfont);
        draw_set_color(c_white);
        draw_set_halign(fa_right);
        xx = obj_screensizer.displayWidth - 32;
        yy = obj_screensizer.displayHeight - 32;
        draw_text(xx, yy, calculateTime(global.save_timer));
        draw_text(xx, yy - 16, calculateTime(global.level_timer));
        
        if (tipText != "")
        {
            draw_set_font(global.creditsfont);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_textEX(obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight - 64, tipText);
            draw_set_alpha(1);
        }
    }
}
