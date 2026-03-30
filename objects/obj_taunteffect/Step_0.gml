if (target.state != states.taunt)
    destroy = true;

if (animation_end())
    image_speed = 0;

if (destroy)
    image_alpha -= 0.04;

if (image_alpha <= 0)
    instance_destroy();
