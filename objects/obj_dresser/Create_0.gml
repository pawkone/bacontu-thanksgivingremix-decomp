depth = 10;
palettes = [];
selected = 0;
textAlpha = 0;
indicatorAlpha = 0;
indicator = false;

addPalette = function(arg0, arg1, arg2, arg3 = true, arg4 = spr_playerPat_threads)
{
    var q = 
    {
        pName: arg0,
        desc: arg1,
        index: arg2,
        sprite: arg4
    };
    
    if (arg3)
    {
        array_push(palettes, q);
        return q;
    }
};

ini_open(global.saveFile);
addPalette("Hotel Wears", "It's You! Tu!", 1, true);
addPalette("Red Wears", "Placeholder", 2, true);
addPalette("Blue Wears", "Placeholder", 3, true);
addPalette("Coffee Wears", "Placeholder", 4, true);
ini_close();

for (var i = 0; i < array_length(palettes); i++)
{
    var q = palettes[i].index;
    var p = palettes[i].sprite;
    
    if (q == obj_player.palIndex && p == global.patternSpr)
    {
        selected = i;
        break;
    }
}
