var _Deadzone = global.gamepadDeadzones.general + global.gamepadDeadzones.press;
_Deadzone = clamp(_Deadzone, 0, 0.99);

if (global.gamepadConnected)
{
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axislh)) < _Deadzone)
        horizontalStickPressed = false;
    
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axislv)) < _Deadzone)
        verticalStickPressed = false;
    
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axisrh)) < _Deadzone)
        horizontalStickPressedR = false;
    
    if (abs(gamepad_axis_value(global.gamepadCurrent, gp_axisrv)) < _Deadzone)
        verticalStickPressedR = false;
}
