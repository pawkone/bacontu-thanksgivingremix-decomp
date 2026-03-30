if (stay)
{
    image_xscale = lerp(image_xscale, 1, 0.1);
    image_yscale = lerp(image_yscale, 1, 0.1);
}
else
{
    if (image_alpha <= 0)
        instance_destroy();
    
    image_alpha -= 0.1;
    image_xscale -= 0.1;
    image_yscale += 0.2;
}
