switch (state)
{
    case states.normal:
        if (camera.target.state == states.mach2 || camera.target.state == states.mach3 || camera.target.state == states.tumble)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 0.3;
            
            if ((far > 0 && xOffset < 0) || (far < 0 && xOffset > 0))
                chargeSpd = 8;
            
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (camera.target.state == states.surfing)
        {
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            var chargeSpd = 4;
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else if (abs(camera.target.hsp) >= 16)
        {
            var chargeSpd = 2.5;
            var far = camera.target.movespeed * 10 * camera.target.xscale;
            xOffset = approach(xOffset, far, chargeSpd);
        }
        else
        {
            xOffset = approach(xOffset, 0, 8);
        }
        
        camera.x = camera.target.x + xOffset;
        camera.y = camera.target.y - 50;
        camera.zoom = lerp(camera.zoom, 1, 0.05);
        break;
}

cameraShake = approach(cameraShake, 0, 1);
var _realX = camera.x - (camera.width / 2);
var _realY = camera.y - (camera.height / 2);
_realX = clamp(_realX, 0, room_width - camera.width);
_realY = clamp(_realY, 0, room_height - camera.height);
camera.width = obj_screensizer.displayWidth * (1 + (1 - camera.zoom));
camera.height = obj_screensizer.displayHeight * (1 + (1 - camera.zoom));
camera_set_view_pos(view_camera[0], _realX + irandom_range(cameraShake, -cameraShake) + irandom_range(-global.escape.active, global.escape.active), _realY + irandom_range(cameraShake, -cameraShake) + irandom_range(-global.escape.active, global.escape.active));
camera_set_view_angle(view_camera[0], camera.angle);
camera_set_view_size(view_camera[0], camera.width, camera.height);
