if (array_length(textures))
{
    var group = textures[0];
    
    for (var i = 0; i < array_length(group); i++)
    {
        show_debug_message(group[i]);
        
        if (!texture_is_ready(group[i]))
            texture_prefetch(group[i]);
    }
    
    array_shift(textures);
    alarm[0] = 5;
}
else
{
    fadeOut = true;
}
