ready = false;
alarm[0] = room_speed * 5;

if (!np_initdiscord("1428526839164436480", true, "0"))
    show_error("NekoPresence init fail.", true);
