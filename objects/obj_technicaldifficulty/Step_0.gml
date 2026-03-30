if (showTechnical == false)
{
    staticIndex += 0.35;
    
    if (staticIndex >= (sprite_get_number(spr_tvstatic) - 1))
    {
        showTechnical = true;
        showStatic = false;
        staticIndex = 0;
        alarm[0] = 90;
    }
}
else if (showTechnical == true)
{
    if (showStatic)
        staticIndex += 0.35;
    
    if (staticIndex >= (sprite_get_number(spr_tvstatic) - 1))
        instance_destroy();
}
