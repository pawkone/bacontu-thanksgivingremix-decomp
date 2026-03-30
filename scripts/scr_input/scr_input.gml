function loadString(_file)
{
    var _buff = buffer_load(_file);
    var _str = buffer_read(_buff, buffer_string);
    buffer_delete(_buff);
    return _str;
}

global.inputMap = {};

function init_input()
{
    if (!file_exists(working_directory + "input.dat"))
    {
        var InputsKey = {};
        InputsKey.left = [37];
        InputsKey.right = [39];
        InputsKey.up = [38];
        InputsKey.down = [40];
        InputsKey.jump = [90];
        InputsKey.slap = [88];
        InputsKey.taunt = [67];
        InputsKey.attack = [16];
        InputsKey.start = [27];
        InputsKey.superjump = [];
        InputsKey.groundpound = [];
        InputsKey.menu_left = [37];
        InputsKey.menu_right = [39];
        InputsKey.menu_up = [38];
        InputsKey.menu_down = [40];
        InputsKey.menu_confirm = [90];
        InputsKey.menu_back = [88];
        InputsKey.menu_clear = [67];
        var InputsPad = {};
        InputsPad.left = [32783, "joyLL"];
        InputsPad.right = [32784, "joyLR"];
        InputsPad.up = [32781, "joyLU"];
        InputsPad.down = [32782, "joyLD"];
        InputsPad.jump = [32769];
        InputsPad.slap = [32771];
        InputsPad.taunt = [32772];
        InputsPad.attack = [32774, 32776];
        InputsPad.start = [32778];
        InputsPad.superjump = [];
        InputsPad.groundpound = [];
        InputsPad.menu_left = [32783, "joyLL"];
        InputsPad.menu_right = [32784, "joyLR"];
        InputsPad.menu_up = [32781, "joyLU"];
        InputsPad.menu_down = [32782, "joyLD"];
        InputsPad.menu_confirm = [32769];
        InputsPad.menu_back = [32771];
        InputsPad.menu_clear = [32772];
        var players = 1;
        var inputs = ["left", "right", "down", "up", "jump", "slap", "taunt", "attack", "start", "superjump", "groundpound", "menu_up", "menu_down", "menu_left", "menu_right", "menu_confirm", "menu_back", "menu_clear"];
        
        for (var i = 0; i < players; i++)
        {
            p = string("Player{0}", i + 1);
            
            for (q = 0; q < array_length(inputs); q++)
            {
                var inp = inputs[q];
                var _inpKey = variable_instance_get(InputsKey, inp);
                var _inpPad = variable_instance_get(InputsPad, inp);
                variable_struct_set(global.inputMap, string("Inputs_{0}_{1}Key", p, inp), _inpKey);
                variable_struct_set(global.inputMap, string("Inputs_{0}_{1}Pad", p, inp), _inpPad);
            }
        }
        
        var q = json_stringify(global.inputMap, true);
        var _file = file_text_open_write(working_directory + "input.dat");
        file_text_write_string(_file, q);
        file_text_close(_file);
        var p = loadString(working_directory + "input.dat");
        global.inputMap = json_parse(p);
    }
    else
    {
        var p = loadString(working_directory + "input.dat");
        global.inputMap = json_parse(p);
    }
    
    show_debug_message("Inputs initiallized!");
}

function reset_input()
{
    var start_time = get_timer();
    global.inputMap = {};
    var InputsKey = {};
    InputsKey.left = [37];
    InputsKey.right = [39];
    InputsKey.up = [38];
    InputsKey.down = [40];
    InputsKey.jump = [90];
    InputsKey.slap = [88];
    InputsKey.taunt = [67];
    InputsKey.attack = [16];
    InputsKey.start = [27];
    InputsKey.superjump = [];
    InputsKey.groundpound = [];
    InputsKey.menu_left = [37];
    InputsKey.menu_right = [39];
    InputsKey.menu_up = [38];
    InputsKey.menu_down = [40];
    InputsKey.menu_confirm = [90];
    InputsKey.menu_back = [88];
    InputsKey.menu_clear = [67];
    var InputsPad = {};
    InputsPad.left = [32783, "joyLL"];
    InputsPad.right = [32784, "joyLR"];
    InputsPad.up = [32781, "joyLU"];
    InputsPad.down = [32782, "joyLD"];
    InputsPad.jump = [32769];
    InputsPad.slap = [32771];
    InputsPad.taunt = [32772];
    InputsPad.attack = [32774, 32776];
    InputsPad.start = [32778];
    InputsPad.superjump = [];
    InputsPad.groundpound = [];
    InputsPad.menu_left = [32783, "joyLL"];
    InputsPad.menu_right = [32784, "joyLR"];
    InputsPad.menu_up = [32781, "joyLU"];
    InputsPad.menu_down = [32782, "joyLD"];
    InputsPad.menu_confirm = [32769];
    InputsPad.menu_back = [32771];
    InputsPad.menu_clear = [32772];
    var players = 1;
    var inputs = ["left", "right", "down", "up", "jump", "slap", "taunt", "attack", "start", "superjump", "groundpound", "menu_up", "menu_down", "menu_left", "menu_right", "menu_confirm", "menu_back", "menu_clear"];
    
    for (var i = 0; i < players; i++)
    {
        p = string("Player{0}", i + 1);
        
        for (q = 0; q < array_length(inputs); q++)
        {
            var inp = inputs[q];
            var _inpKey = variable_instance_get(InputsKey, inp);
            var _inpPad = variable_instance_get(InputsPad, inp);
            variable_struct_set(global.inputMap, string("Inputs_{0}_{1}Key", p, inp), _inpKey);
            variable_struct_set(global.inputMap, string("Inputs_{0}_{1}Pad", p, inp), _inpPad);
        }
    }
    
    var q = json_stringify(global.inputMap, true);
    var _file = file_text_open_write(working_directory + "input.dat");
    file_text_write_string(_file, q);
    file_text_close(_file);
    var p = loadString(working_directory + "input.dat");
    global.inputMap = json_parse(p);
    var end_time = get_timer();
    var timeFinal = end_time - start_time;
    show_debug_message("Inputs reset in {0}ms!", timeFinal);
}

function read_input(_inputstr, _pressed = false)
{
    var canRead = true;
    var _returnKey = false;
    var _returnPad = false;
    var keyboardKey = variable_struct_get(global.inputMap, string("Inputs_Player{0}_{1}Key", key_player, _inputstr));
    var gamepadButton = variable_struct_get(global.inputMap, string("Inputs_Player{0}_{1}Pad", key_player, _inputstr));
    var _axLH = gamepad_axis_value(global.gamepadCurrent, gp_axislh);
    var _axLV = gamepad_axis_value(global.gamepadCurrent, gp_axislv);
    var _axRH = gamepad_axis_value(global.gamepadCurrent, gp_axisrh);
    var _axRV = gamepad_axis_value(global.gamepadCurrent, gp_axisrv);
    var _pDeadzone = global.gamepadDeadzones.general + global.gamepadDeadzones.press;
    _pDeadzone = clamp(_pDeadzone, 0, 0.99);
    var _horizDeadzone = global.gamepadDeadzones.general + global.gamepadDeadzones.horizontal;
    _horizDeadzone = clamp(_horizDeadzone, 0, 0.99);
    var _vertDeadzone = global.gamepadDeadzones.general + global.gamepadDeadzones.vertical;
    _vertDeadzone = clamp(_vertDeadzone, 0, 0.99);
    
    switch (_pressed)
    {
        case true:
            if (array_length(keyboardKey) != 0)
            {
                for (var i = 0; i < array_length(keyboardKey); i++)
                {
                    if (keyboard_check_pressed(keyboardKey[i]))
                        _returnKey = true;
                }
            }
            
            if (array_length(gamepadButton) != 0)
            {
                for (var i = 0; i < array_length(gamepadButton); i++)
                {
                    if (is_string(gamepadButton[i]))
                    {
                        switch (gamepadButton[i])
                        {
                            case "joyLL":
                                if (_axLH < -_pDeadzone && obj_inputController.horizontalStickPressed == false)
                                {
                                    obj_inputController.horizontalStickPressed = approach(obj_inputController.horizontalStickPressed, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyLR":
                                if (_axLH > _pDeadzone && obj_inputController.horizontalStickPressed == false)
                                {
                                    obj_inputController.horizontalStickPressed = approach(obj_inputController.horizontalStickPressed, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyLU":
                                if (_axLV < -_pDeadzone && obj_inputController.verticalStickPressed == false)
                                {
                                    obj_inputController.verticalStickPressed = approach(obj_inputController.verticalStickPressed, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyLD":
                                if (_axLV > _pDeadzone && obj_inputController.verticalStickPressed == false)
                                {
                                    obj_inputController.verticalStickPressed = approach(obj_inputController.verticalStickPressed, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyRL":
                                if (_axRH < -_pDeadzone && obj_inputController.horizontalStickPressedR == false)
                                {
                                    obj_inputController.horizontalStickPressedR = approach(obj_inputController.horizontalStickPressedR, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyRR":
                                if (_axRH > _pDeadzone && obj_inputController.horizontalStickPressedR == false)
                                {
                                    obj_inputController.horizontalStickPressedR = approach(obj_inputController.horizontalStickPressedR, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyRU":
                                if (_axRV < -_pDeadzone && obj_inputController.verticalStickPressedR == false)
                                {
                                    obj_inputController.verticalStickPressedR = approach(obj_inputController.verticalStickPressedR, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                            
                            case "joyRD":
                                if (_axRV > _pDeadzone && obj_inputController.verticalStickPressedR == false)
                                {
                                    obj_inputController.verticalStickPressedR = approach(obj_inputController.verticalStickPressedR, true, 0.1);
                                    _returnPad = true;
                                }
                                
                                break;
                        }
                    }
                    else if (gamepad_button_check_pressed(global.gamepadCurrent, gamepadButton[i]))
                    {
                        _returnPad = true;
                    }
                }
            }
            
            break;
        
        case false:
            if (array_length(keyboardKey) != 0)
            {
                for (var i = 0; i < array_length(keyboardKey); i++)
                {
                    if (keyboard_check(keyboardKey[i]))
                        _returnKey = true;
                }
            }
            
            if (array_length(gamepadButton) != 0)
            {
                for (var i = 0; i < array_length(gamepadButton); i++)
                {
                    if (is_string(gamepadButton[i]))
                    {
                        switch (gamepadButton[i])
                        {
                            case "joyLL":
                                if (_axLH < -_horizDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyLR":
                                if (_axLH > _horizDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyLU":
                                if (_axLV < -_vertDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyLD":
                                if (_axLV > _vertDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyRL":
                                if (_axRH < -_horizDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyRR":
                                if (_axRH > _horizDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyRU":
                                if (_axRV < -_vertDeadzone)
                                    _returnPad = true;
                                
                                break;
                            
                            case "joyRD":
                                if (_axRV > _vertDeadzone)
                                    _returnPad = true;
                                
                                break;
                        }
                    }
                    else if (gamepad_button_check(global.gamepadCurrent, gamepadButton[i]))
                    {
                        _returnPad = true;
                    }
                }
            }
            
            break;
    }
    
    if (canRead)
        return _returnKey || _returnPad;
    else
        return false;
}

function getMenu_input()
{
    key_player = 1;
    key_left = -read_input("menu_left");
    key_left2 = -read_input("menu_left", true);
    key_right = read_input("menu_right");
    key_right2 = read_input("menu_right", true);
    key_up = read_input("menu_up");
    key_up2 = read_input("menu_up", true);
    key_down = read_input("menu_down");
    key_down2 = read_input("menu_down", true);
    key_jump = read_input("menu_confirm");
    key_jump2 = read_input("menu_confirm", true);
    key_slap = read_input("menu_back");
    key_slap2 = read_input("menu_back", true);
    key_taunt = read_input("menu_clear");
    key_taunt2 = read_input("menu_clear", true);
    key_start2 = read_input("start", true);
}

function get_input()
{
    key_player = 1;
    key_left = -read_input("left");
    key_left2 = -read_input("left", true);
    key_right = read_input("right");
    key_right2 = read_input("right", true);
    key_up = read_input("up");
    key_up2 = read_input("up", true);
    key_down = read_input("down");
    key_down2 = read_input("down", true);
    key_jump = read_input("jump");
    key_jump2 = read_input("jump", true);
    key_slap = read_input("slap");
    key_slap2 = read_input("slap", true);
    key_taunt = read_input("taunt");
    key_taunt2 = read_input("taunt", true);
    key_attack = read_input("attack");
    key_attack2 = read_input("attack", true);
    key_start = read_input("start");
    key_start2 = read_input("start", true);
    key_superjump = read_input("superjump");
    key_superjump2 = read_input("superjump", true);
    key_groundpound = read_input("groundpound");
    key_groundpound2 = read_input("groundpound", true);
}
