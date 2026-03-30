if (place_meeting(x, y, obj_player))
{
    if (obj_player.key_up2)
    {
        selected++;
        selected = wrap(selected, 0, array_length(palettes) - 1);
        
        with (obj_player)
        {
            palIndex = other.palettes[other.selected].index;
            global.patternSpr = other.palettes[other.selected].sprite;
            create_particleStatic(spr_genericpoofeffect, x, y, 1, -1);
        }
    }
}

textAlpha = approach(textAlpha, place_meeting(x, y, obj_player), 0.1);
indicatorAlpha = approach(indicatorAlpha, indicator, 0.1);
