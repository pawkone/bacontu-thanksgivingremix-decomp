if (global.escape.active)
{
    image_alpha = 1;
    x = -100;
    y = -100;
    sprite_index = spr_monolithblock_sleep;
}
else
{
    image_alpha = 1;
    x = xstart;
    y = ystart;
    sprite_index = spr_monolithblock_wake;
}
