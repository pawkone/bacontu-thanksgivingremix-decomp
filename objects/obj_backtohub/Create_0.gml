start = false;
image_alpha = 1.1;
fakeVsp = 5;

with (obj_player)
{
    hsp = 0;
    vsp = 0;
    state = -4;
    x = backtohubX - 16;
    y = backtohubY;
    obj_camera.state = -4;
    obj_camera.camera.x = backtohubX;
    obj_camera.camera.y = backtohubY - 50;
    y = backtohubY - (obj_screensizer.displayHeight * 1.4);
    sprite_index = spr_player_spinout;
    image_speed = 0.35;
    other.alarm[0] = 60;
}
