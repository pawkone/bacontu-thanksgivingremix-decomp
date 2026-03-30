image_xscale = lerp(image_xscale, ringPower, 0.05);
image_yscale = lerp(image_yscale, ringPower, 0.05);

if (image_xscale > (ringPower - 4))
    image_alpha -= (1/15);

if (amp <= 0.0001)
    instance_destroy();

amp = lerp(amp, 0, 0.05);
