var _et = ds_map_find_value(async_load, "event_type");

if (_et == "gamepad discovered")
{
    var _padIndx = ds_map_find_value(async_load, "pad_index");
    
    if (global.gamepadConnected == false)
    {
        global.gamepadConnected = true;
        global.gamepadCurrent = _padIndx;
        show_debug_message(string("Gamepad at slot {0} has been Found!", _padIndx));
    }
}
else if (_et == "gamepad lost")
{
    var _padIndx = ds_map_find_value(async_load, "pad_index");
    
    if (global.gamepadConnected == true)
    {
        global.gamepadConnected = false;
        global.gamepadCurrent = -4;
        show_debug_message(string("Gamepad at slot {0} has disconnected.", _padIndx));
    }
}
