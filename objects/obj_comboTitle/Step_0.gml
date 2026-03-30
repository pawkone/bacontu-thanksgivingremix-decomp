if (y > 240)
    y = obj_hud.combometer.y + 110;

scale = lerp(scale, 1, 0.2);

if (fade == true)
{
    image_alpha = lerp(image_alpha, 0, 0.2);
    
    if (image_alpha < 0.1)
        instance_destroy();
}
