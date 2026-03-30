if (scene == 0 || scene == 1)
{
    if (fadeIn == true)
    {
        fadeAlpha = approach(fadeAlpha, 1, 0.05);
        
        if (fadeAlpha == 1)
        {
            fadeIn = false;
            scene = 1;
            alarm[0] = 120;
            alarm[1] = 210;
        }
    }
    else if (fadeIn == false)
    {
        fadeAlpha = approach(fadeAlpha, 0, 0.1);
    }
    
    if (titlecardName.fadeIn == true)
    {
        titlecardName.alpha = approach(titlecardName.alpha, 0, 0.05);
        
        if (titlecardName.alpha == 0)
        {
            titlecardName.fadeIn = false;
            titlecardName.index = 2;
        }
    }
    else if (titlecardName.fadeIn == false)
    {
        titlecardName.alpha = approach(titlecardName.alpha, 1, 0.1);
    }
}

if (scene == 2)
{
    circleSize = approach(circleSize, 0, circleSizeSpeed);
    circleSizeSpeed += 1;
    
    if (circleSize == 0)
    {
        scene = 3;
        alarm[2] = 45;
    }
}

if (scene == 4)
{
    circleSize = approach(circleSize, obj_screensizer.displayWidth, circleSizeSpeed);
    circleSizeSpeed += 1;
    
    if (circleSize == obj_screensizer.displayWidth)
    {
        scene = 5;
        alarm[3] = 25;
    }
}

if (scene == 6)
{
    ratingAlpha = approach(ratingAlpha, 1, 0.1);
    
    if (ratingAlpha == 1 && alarm[3] <= 0)
        alarm[3] = 180;
}

if (scene == 7)
{
    ratingAlpha = approach(ratingAlpha, 0, 0.01);
    
    if (ratingAlpha == 0)
        instance_destroy();
}
