if (cutscene)
{
    visible = true;
    timer--;
    obj_camera.camera.zoom = 1.5;
    x = xstart + irandom_range(10, 10);
    y = ystart + irandom_range(10, 10);
    
    with (obj_player)
    {
        x = other.x;
        y = other.y;
    }
    
    if (timer <= 0)
    {
        obj_camera.camera.zoom = 1;
        global.escape.party = true;
        obj_camera.camera.angle = 0;
        instance_destroy();
        
        with (obj_player)
        {
            jumpstop = true;
            vsp = -9;
            state = states.jump;
            xs = 1;
            ys = 1;
        }
    }
}
