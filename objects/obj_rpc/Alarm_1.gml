np_setpresence_more("", "What's Shakin, Bacon?", false);
var _details = "Playing the Game";
var _state = "";
var _rank = "D";

if (global.collect >= global.Srank)
    _rank = "S";
else if (global.collect >= global.Arank)
    _rank = "A";
else if (global.collect >= global.Brank)
    _rank = "B";
else if (global.collect >= global.Crank)
    _rank = "C";

if (global.level != -4)
{
    _state = string_concat(calculateTime(global.level_timer), " | Score: ", global.collect, " | Combo: ", global.combo.amt, " (", global.combo.dropped ? "Non P-Rank)" : "P-Rank)", " | Rank: ", _rank);
    
    switch (global.level)
    {
        case "forest":
            _details = "Monolith Mangrove";
            break;
        
        case "gutter":
            _details = "John Gutter 2";
            break;
        
        case "shores":
            _details = "Wasted Shores";
            break;
    }
}

np_setpresence(_details, _state, "", "");
alarm[1] = 5;
