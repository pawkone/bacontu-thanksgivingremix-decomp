if (!surface_exists(fadeSurface))
    fadeSurface = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);

surface_set_target(fadeSurface);
draw_clear_alpha(c_black, 0);
draw_set_color(c_black);
draw_rectangle(0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false);
draw_set_color(c_white);
gpu_set_blendmode(bm_subtract);

if (instance_exists(obj_player))
{
    var _x = obj_player.x - camera_get_view_x(view_camera[0]);
    _x = clamp(_x, 32, obj_screensizer.displayWidth - 32);
    var _y = obj_player.y - camera_get_view_y(view_camera[0]);
    
    if (circleSize != 0)
    {
        draw_circle(_x + irandom_range(2, -2), _y + irandom_range(2, -2), circleSize, false);
        draw_set_alpha(0.5);
        draw_circle(_x + irandom_range(2, -2), _y + irandom_range(2, -2), circleSize + 12, false);
        draw_set_alpha(1);
    }
}

gpu_set_blendmode(bm_normal);
surface_reset_target();

if (dark)
{
    draw_set_alpha(0.6);
    draw_surface(fadeSurface, 0, 0);
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_font(global.bigfont);
    draw_text(128, obj_screensizer.displayHeight - 128, string("{0} PUMPKINS LEFT", global.pumpkins.amount - global.pumpkins.count));
}
