if (!dontdraw)
{
    image_angle += grav;
    vsp += grav;
    y += vsp;
    
    if (y > (obj_screensizer.displayHeight - 20))
    {
        repeat (8)
        {
            self.particleDebri(spr_vasedebris, i2, x, y, 1, random_range(0, 360), irandom_range(-12, -5), irandom_range(-8, -12));
            i2 += 1;
        }
        
        FMODevent_oneshot("event:/Sfx/General/Level/metalbreak", x, y);
        dontdraw = true;
    }
}

if (!ds_list_empty(particles))
{
    for (var i = 0; i < ds_list_size(particles); i++)
    {
        var q = ds_list_find_value(particles, i);
        
        with (q)
        {
            x += hsp;
            y += vsp;
            vsp += grav;
            
            if (y > (obj_screensizer.displayHeight + 150))
            {
                with (other)
                {
                    q = undefined;
                    ds_list_delete(particles, i);
                    i--;
                }
            }
        }
    }
}

if (dontdraw && ds_list_size(particles) == 0)
    instance_destroy();
