var ev_type = ds_map_find_value(async_load, "event_type");

if (ev_type == "DiscordReady")
{
    global.discord_initialized = true;
    ready = true;
    show_debug_message("date: " + string(date_current_datetime()));
    np_setpresence_timestamps(date_current_datetime(), 0, false);
    np_setpresence_more("Small image text", "Large image text", false);
    alarm[1] = 2;
    sprite_add(np_get_avatar_url(ds_map_find_value(async_load, "user_id"), ds_map_find_value(async_load, "avatar")), 1, false, false, 0, 0);
    global.username = ds_map_find_value(async_load, "username");
}
