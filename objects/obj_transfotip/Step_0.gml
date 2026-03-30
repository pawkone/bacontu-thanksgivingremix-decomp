alpha = approach(alpha, fadein, fadein ? 0.05 : 0.01);

if (fadein == false && alpha == 0)
    instance_destroy();
