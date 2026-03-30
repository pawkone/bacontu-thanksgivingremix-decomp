if (target == -4)
{
    var _found = false;
    var _objPl = -4;
    
    for (var i = 0; i < instance_number(obj_onlinePlayer); i++)
    {
        var obj = instance_find(obj_onlinePlayer, i);
        
        if (obj.onlineID == onlineID)
        {
            _found = true;
            _objPl = obj;
        }
    }
    
    if (_found)
        target = _objPl;
}
else
{
    if (target.state != states.taunt)
        destroy = true;
    
    if (animation_end())
        image_speed = 0;
    
    if (destroy)
        image_alpha -= 0.04;
    
    if (image_alpha <= 0)
        instance_destroy();
}
