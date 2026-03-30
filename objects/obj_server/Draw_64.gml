draw_set_font(global.smallfont);

if (!ds_list_empty(notifs))
{
    for (var i = 0; i < ds_list_size(notifs); i++)
    {
        draw_set_color(ds_list_find_value(notifs, i).color);
        draw_set_alpha(ds_list_find_value(notifs, i).alpha);
        draw_set_halign(fa_left);
        draw_text(16, obj_screensizer.displayHeight - 32 - (42 * i), string_lower(ds_list_find_value(notifs, i).text));
        draw_set_color(c_white);
        draw_set_alpha(1);
        ds_list_find_value(notifs, i).gotime--;
        ds_list_find_value(notifs, i).alpha = ds_list_find_value(notifs, i).gotime / 30;
        
        if (ds_list_find_value(notifs, i).gotime <= 0)
            ds_list_delete(notifs, i);
    }
}
