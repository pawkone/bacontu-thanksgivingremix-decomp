global.collect += 5;
points -= 5;
var _sprite = asset_get_index(string("spr_lover_chocolate{0}", irandom_range(1, 3)));
create_collect(_sprite, x, y);
FMODevent_oneshot("event:/Sfx/General/Collects/collect", x, y);

if (points > 0)
    alarm[0] = 4;
else
    alarm[1] = 25;
