if (active)
{
    for (var i = 0; i < points; i++)
    {
        global.collect += 1;
        var _sprite = asset_get_index(string("spr_collect{0}", irandom_range(1, 5)));
        create_collect(_sprite, x + irandom_range(-50, 50), y + irandom_range(-50, 50));
    }
}
