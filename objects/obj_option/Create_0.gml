enum optionstype
{
	mainpage, // 0
	audio, // 1
	video, // 2
	window, // 3
	controls, // 4
	controls_keyboard, // 5
	controls_keyboard_config, // 6
	controls_pad, // 7
	controls_pad_config, // 8
	controls_pad_deadzones, // 9
	game, // 10
	anchor_center, // 11
	anchor_left, // 12
	anchor_controls, // 13
	element_button, // 14
	element_toggle, // 15
	element_slider, // 16
	element_bind, // 17
}

buffer = 0;
menus = [];
currentmenu = 0;
selected = 0;
move = 0;
backgrounds = [];
changingBind = false;
keyScroll = 0;

var addBackground = function(arg0 = [], arg1, arg2 = 0)
{
    var q = 
    {
        menu: arg0,
        index: arg1,
        alpha: arg2
    };
    array_push(backgrounds, q);
};

addBackground([0], 0, 1);
addBackground([1], 1);
addBackground([2, 10], 2);
addBackground([3], 3);
addBackground([4, 5, 6, 7, 8, 9], 4);
BGX = wave(-32, 32, 5, 0);
BGY = 0;
depth = obj_pause.depth - 1;
screamSnd = FMODcreate_event("event:/Sfx/UI/Pause/slider");
fmod_studio_event_instance_start(screamSnd);
fmod_studio_event_instance_set_paused(screamSnd, true);

addPause_icon = function(arg0) constructor
{
    index = arg0;
    alpha = 0;
};

goto_menu = function(arg0)
{
    for (var i = 0; i < array_length(menus); i++)
    {
        var m = menus[i];
        
        if (m.menuid == arg0)
            currentmenu = i;
    }
    
    show_debug_message(currentmenu);
    selected = 0;
};

create_menu = function(arg0, arg1, arg2, arg3)
{
    var _opt = 
    {
        menuid: arg0,
        anchor: arg1,
        ypad: arg2,
        options: [],
        backfunc: arg3
    };
    return _opt;
};

add_option_press = function(arg0, arg1, arg2, arg3 = -4)
{
    var q = 
    {
        name: arg1,
        func: arg2,
        type: optionstype.element_button,
        selecting: false,
        icon: arg3
    };
    array_push(arg0.options, q);
    return q;
};

add_option_ext = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6 = ["option_off", "option_on"])
{
    var q = 
    {
        specialNumber: 0,
        name: arg2,
        func: arg3,
        val: arg4,
        toggle: arg6,
        type: arg1,
        max: arg5,
        moving: false,
        selecting: false
    };
    array_push(arg0.options, q);
    return q;
};

add_option_key = function(arg0, arg1, arg2, arg3 = "Inputs_Player1_leftKey")
{
    var q = 
    {
        type: optionstype.element_bind,
        iconIndex: arg1,
        key: arg3,
        func: arg2,
        selecting: false
    };
    array_push(arg0.options, q);
    return q;
};

var category = create_menu(optionstype.mainpage, optionstype.anchor_center, 48, function()
{
    obj_pause.buffer = 2;
    instance_destroy();
});
add_option_press(category, "option_audio", function()
{
    goto_menu(optionstype.audio);
}, new addPause_icon(4));
add_option_press(category, "option_video", function()
{
    goto_menu(optionstype.video);
}, new addPause_icon(5));
add_option_press(category, "option_game", function()
{
    goto_menu(optionstype.game);
}, new addPause_icon(6));
add_option_press(category, "option_controls", function()
{
    goto_menu(optionstype.controls);
}, new addPause_icon(7));
array_push(menus, category);
var AUDIO = create_menu(optionstype.audio, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
    add_saveVariable("General", "Music", global.MusicVolume);
    add_saveVariable("General", "Master", global.MasterVolume);
    add_saveVariable("General", "Sfx", global.SfxVolume);
    add_saveVariable("General", "Unfocus Mute", global.unfocus_mute);
});
add_option_press(AUDIO, "option_back", function()
{
    goto_menu(optionstype.mainpage);
    add_saveVariable("General", "Music", global.MusicVolume);
    add_saveVariable("General", "Master", global.MasterVolume);
    add_saveVariable("General", "Sfx", global.SfxVolume);
    add_saveVariable("General", "Unfocus Mute", global.unfocus_mute);
});
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_master", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.MasterVolume = q.val / 100;
    q.val = global.MasterVolume * 100;
}, global.MasterVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_music", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.MusicVolume = q.val / 100;
    q.val = global.MusicVolume * 100;
}, global.MusicVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_ambiance", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.AmbianceVolume = q.val / 100;
    q.val = global.AmbianceVolume * 100;
}, global.AmbianceVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_slider, "option_audio_sfx", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.SfxVolume = q.val / 100;
    q.val = global.SfxVolume * 100;
}, global.SfxVolume * 100, 100);
add_option_ext(AUDIO, optionstype.element_toggle, "option_audio_unfocus", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.unfocus_mute = q.val;
    q.val = global.unfocus_mute;
}, global.unfocus_mute, 1);
var VIDEO = create_menu(optionstype.video, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
    add_saveVariable("Visual", "showHud", global.hide_hud);
    add_saveVariable("General", "Vsync", global.vsync);
    add_saveVariable("General", "Windowsize", global.windowSize);
    add_saveVariable("General", "texFilter", global.texFilter);
});
add_option_press(VIDEO, "option_back", function()
{
    goto_menu(optionstype.mainpage);
    add_saveVariable("Visual", "showHud", global.hide_hud);
    add_saveVariable("General", "Vsync", global.vsync);
    add_saveVariable("General", "Windowsize", global.windowSize);
    add_saveVariable("General", "texFilter", global.texFilter);
});
add_option_press(VIDEO, "option_video_window_mode", function()
{
    goto_menu(optionstype.window);
});
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_resolution", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]];
    window_set_size(res[q.val][0], res[q.val][1]);
    window_center();
    global.windowSize = q.val;
    q.val = global.windowSize;
}, global.windowSize, 5, ["480 X 270", "960 X 540", "1024 X 576", "1280 X 720", "1600 X 900", "1920 X 1080"]);
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_vsync", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.vsync = q.val;
    display_reset(0, global.vsync);
    q.val = global.vsync;
}, global.vsync, 1);
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_filtering", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.texFilter = q.val;
    gpu_set_texfilter(global.texFilter);
    q.val = global.texFilter;
}, global.texFilter, 1);
add_option_ext(VIDEO, optionstype.element_toggle, "option_video_hide_hud", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.hide_hud = q.val;
    q.val = global.hide_hud;
}, global.hide_hud, 1);
var GAME = create_menu(optionstype.game, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
});
add_option_press(GAME, "option_back", function()
{
    goto_menu(optionstype.mainpage);
});
var controlsMain = create_menu(optionstype.controls, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.mainpage);
});
add_option_press(controlsMain, "option_back", function()
{
    goto_menu(optionstype.mainpage);
});
add_option_press(controlsMain, "option_controls_keyboard", function()
{
    goto_menu(optionstype.controls_keyboard);
});
add_option_press(controlsMain, "option_controls_controller", function()
{
    goto_menu(optionstype.controls_pad);
});
add_option_press(controlsMain, "option_controls_reset_config", function()
{
    reset_input();
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_reset_tip"));
    _s.depth = depth - 1;
});
var controlsKeyMain = create_menu(optionstype.controls_keyboard, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.controls);
    add_saveVariable("General", "dirSuper", global.dirSuper);
    add_saveVariable("General", "dirGround", global.dirGround);
});
add_option_press(controlsKeyMain, "option_back", function()
{
    goto_menu(optionstype.controls);
    add_saveVariable("General", "dirSuper", global.dirSuper);
    add_saveVariable("General", "dirGround", global.dirGround);
});
add_option_press(controlsKeyMain, "option_controls_bindings", function()
{
    goto_menu(optionstype.controls_keyboard_config);
});
add_option_ext(controlsKeyMain, optionstype.element_toggle, "option_controls_controller_dir_superjump", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.dirSuper = q.val;
    q.val = global.dirSuper;
}, global.dirSuper, 1);
add_option_ext(controlsKeyMain, optionstype.element_toggle, "option_controls_controller_dir_groundpound", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.dirGround = q.val;
    q.val = global.dirGround;
}, global.dirGround, 1);
var controlsPadMain = create_menu(optionstype.controls_pad, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.controls);
});
add_option_press(controlsPadMain, "option_back", function()
{
    goto_menu(optionstype.controls);
});
add_option_press(controlsPadMain, "option_controls_bindings", function()
{
    goto_menu(optionstype.controls_pad_config);
});
add_option_press(controlsPadMain, "option_controls_deadzones", function()
{
    goto_menu(optionstype.controls_pad_deadzones);
});
var controlsKey = create_menu(optionstype.controls_keyboard_config, optionstype.anchor_controls, 64, function()
{
    var q = json_stringify(global.inputMap, true);
    var _file = file_text_open_write(working_directory + "input.dat");
    file_text_write_string(_file, q);
    file_text_close(_file);
    var p = loadString(working_directory + "input.dat");
    goto_menu(optionstype.controls_keyboard);
});
add_option_press(controlsKey, "option_back", function()
{
    goto_menu(optionstype.controls_keyboard);
    var json = json_stringify(global.inputMap, true);
    var _file = file_text_open_write(working_directory + "input.dat");
    file_text_write_string(_file, json);
    file_text_close(_file);
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"));
    _s.depth = depth - 1;
});
add_option_key(controlsKey, 0, function()
{
}, "Inputs_Player1_upKey");
add_option_key(controlsKey, 1, function()
{
}, "Inputs_Player1_downKey");
add_option_key(controlsKey, 3, function()
{
}, "Inputs_Player1_leftKey");
add_option_key(controlsKey, 2, function()
{
}, "Inputs_Player1_rightKey");
add_option_key(controlsKey, 4, function()
{
}, "Inputs_Player1_jumpKey");
add_option_key(controlsKey, 5, function()
{
}, "Inputs_Player1_slapKey");
add_option_key(controlsKey, 6, function()
{
}, "Inputs_Player1_attackKey");
add_option_key(controlsKey, 7, function()
{
}, "Inputs_Player1_tauntKey");
add_option_key(controlsKey, 8, function()
{
}, "Inputs_Player1_startKey");
add_option_key(controlsKey, 9, function()
{
}, "Inputs_Player1_superjumpKey");
add_option_key(controlsKey, 10, function()
{
}, "Inputs_Player1_groundpoundKey");
add_option_key(controlsKey, "MENU LEFT", function()
{
}, "Inputs_Player1_menu_leftKey");
add_option_key(controlsKey, "MENU RIGHT", function()
{
}, "Inputs_Player1_menu_rightKey");
add_option_key(controlsKey, "MENU UP", function()
{
}, "Inputs_Player1_menu_upKey");
add_option_key(controlsKey, "MENU DOWN", function()
{
}, "Inputs_Player1_menu_downKey");
add_option_key(controlsKey, "MENU CONFIRM", function()
{
}, "Inputs_Player1_menu_confirmKey");
add_option_key(controlsKey, "MENU BACK", function()
{
}, "Inputs_Player1_menu_backKey");
add_option_key(controlsKey, "MENU CLEAR", function()
{
}, "Inputs_Player1_menu_clearKey");
var controlsPad = create_menu(optionstype.controls_pad_config, optionstype.anchor_controls, 55, function()
{
    goto_menu(optionstype.controls_pad);
});
add_option_press(controlsPad, "option_back", function()
{
    goto_menu(optionstype.controls_pad);
    var json = json_stringify(global.inputMap, true);
    var _file = file_text_open_write(working_directory + "input.dat");
    file_text_write_string(_file, json);
    file_text_close(_file);
    var _s = scr_transfotip(lang_get_phrase("option_controls_config_save_tip"));
    _s.depth = depth - 1;
});
add_option_key(controlsPad, 0, function()
{
}, "Inputs_Player1_upPad");
add_option_key(controlsPad, 1, function()
{
}, "Inputs_Player1_downPad");
add_option_key(controlsPad, 3, function()
{
}, "Inputs_Player1_leftPad");
add_option_key(controlsPad, 2, function()
{
}, "Inputs_Player1_rightPad");
add_option_key(controlsPad, 4, function()
{
}, "Inputs_Player1_jumpPad");
add_option_key(controlsPad, 5, function()
{
}, "Inputs_Player1_slapPad");
add_option_key(controlsPad, 6, function()
{
}, "Inputs_Player1_attackPad");
add_option_key(controlsPad, 7, function()
{
}, "Inputs_Player1_tauntPad");
add_option_key(controlsPad, 8, function()
{
}, "Inputs_Player1_startPad");
add_option_key(controlsPad, 9, function()
{
}, "Inputs_Player1_superjumpPad");
add_option_key(controlsPad, 10, function()
{
}, "Inputs_Player1_groundpoundPad");
add_option_key(controlsPad, "MENU LEFT", function()
{
}, "Inputs_Player1_menu_leftPad");
add_option_key(controlsPad, "MENU RIGHT", function()
{
}, "Inputs_Player1_menu_rightPad");
add_option_key(controlsPad, "MENU UP", function()
{
}, "Inputs_Player1_menu_upPad");
add_option_key(controlsPad, "MENU DOWN", function()
{
}, "Inputs_Player1_menu_downPad");
add_option_key(controlsPad, "MENU CONFIRM", function()
{
}, "Inputs_Player1_menu_confirmPad");
add_option_key(controlsPad, "MENU BACK", function()
{
}, "Inputs_Player1_menu_backPad");
add_option_key(controlsPad, "MENU CLEAR", function()
{
}, "Inputs_Player1_menu_clearPad");
var DEADZONES = create_menu(optionstype.controls_pad_deadzones, optionstype.anchor_left, 55, function()
{
    goto_menu(optionstype.controls_pad);
    add_saveVariable("Deadzones", "general", global.gamepadDeadzones.general);
    add_saveVariable("Deadzones", "horiz", global.gamepadDeadzones.horizontal);
    add_saveVariable("Deadzones", "verti", global.gamepadDeadzones.vertical);
    add_saveVariable("Deadzones", "press", global.gamepadDeadzones.press);
});
add_option_press(DEADZONES, "option_back", function()
{
    goto_menu(optionstype.controls_pad);
    add_saveVariable("Deadzones", "general", global.gamepadDeadzones.general);
    add_saveVariable("Deadzones", "horiz", global.gamepadDeadzones.horizontal);
    add_saveVariable("Deadzones", "verti", global.gamepadDeadzones.vertical);
    add_saveVariable("Deadzones", "press", global.gamepadDeadzones.press);
});
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_general", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.general = q.val / 100;
    q.val = global.gamepadDeadzones.general * 100;
}, global.gamepadDeadzones.general * 100, 100);
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_horiz", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.horizontal = q.val / 100;
    q.val = global.gamepadDeadzones.horizontal * 100;
}, global.gamepadDeadzones.horizontal * 100, 100);
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_vert", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.vertical = q.val / 100;
    q.val = global.gamepadDeadzones.vertical * 100;
}, global.gamepadDeadzones.vertical * 100, 100);
add_option_ext(DEADZONES, optionstype.element_slider, "option_controls_controller_deadzone_press", function()
{
    var m = menus[currentmenu];
    var opt = m.options;
    var q = opt[selected];
    global.gamepadDeadzones.press = q.val / 100;
    q.val = global.gamepadDeadzones.press * 100;
}, global.gamepadDeadzones.press * 100, 100);
var windowMode = create_menu(optionstype.window, optionstype.anchor_left, 48, function()
{
    goto_menu(optionstype.video);
});
add_option_press(windowMode, "option_back", function()
{
    goto_menu(optionstype.video);
    add_saveVariable("General", "Fullscreen", global.Fullscreen);
});
add_option_press(windowMode, "option_video_window_mode_windowed", function()
{
    goto_menu(optionstype.video);
    window_set_fullscreen(false);
    window_enable_borderless_fullscreen(false);
    global.Fullscreen = 0;
    add_saveVariable("General", "Fullscreen", global.Fullscreen);
});
add_option_press(windowMode, "option_video_window_mode_fullscreen", function()
{
    goto_menu(optionstype.video);
    window_enable_borderless_fullscreen(false);
    window_set_fullscreen(true);
    global.Fullscreen = 1;
    add_saveVariable("General", "Fullscreen", global.Fullscreen);
});
add_option_press(windowMode, "option_video_window_mode_borderless", function()
{
    goto_menu(optionstype.video);
    
    if (window_get_fullscreen())
        window_set_fullscreen(false);
    
    window_enable_borderless_fullscreen(true);
    window_set_fullscreen(true);
    global.Fullscreen = 2;
    add_saveVariable("General", "Fullscreen", global.Fullscreen);
});
array_push(menus, AUDIO);
array_push(menus, VIDEO);
array_push(menus, GAME);
array_push(menus, controlsMain);
array_push(menus, controlsKeyMain);
array_push(menus, controlsKey);
array_push(menus, controlsPadMain);
array_push(menus, controlsPad);
array_push(menus, DEADZONES);
array_push(menus, windowMode);
