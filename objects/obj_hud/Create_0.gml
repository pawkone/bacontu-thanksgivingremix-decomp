kettle = {};
kettle.x = 124;
kettle.y = 74;
kettle.kx = kettle.x;
kettle.ky = kettle.y;
kettle.rankScale = 0;
kettle.previousRank = 0;
kettle.cloudIndex = 0;
depth = -500;
collectVis = ds_list_create();
tv = {};
tv.state = states.normal;
tv.sprite_index = spr_tv_off;
tv.image_index = 0;
tv.image_speed = 0.35;
tv.x = obj_screensizer.displayWidth - 148;
tv.y = 100;
tv.expressionSprite = spr_tv_idle;
tv.expressionTimer = 0;
tv.switchindex = 0;
combometer = {};
combometer.x = 811;
combometer.y = 237;
combometer.catx = (combometer.x - 116) + 199;
combometer.caty = combometer.y - 3;
combometer.catvsp = 0;
combometer.vsp = 0;
combometer.state = -1;
combometer.vasedestroyed = false;
combometer.vaseoffset = 0;

hudVisible = function()
{
    var _rooms = room == rm_intro || room == rank_room || room == avocadoMenu || room == serverMenuShit || room == hotel_entrance || room == hotel_reception || room == hotel_1 || room == hotel_2;
    return !_rooms;
};

global.Srank = 14500;
