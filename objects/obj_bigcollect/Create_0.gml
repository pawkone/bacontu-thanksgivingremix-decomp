sprite_index = asset_get_index(string("spr_bigcollect{0}", irandom_range(1, 5)));
image_speed = 0.35;
canmove = place_empty(x, y, obj_solid);
gotoplayer = false;
movespeed = 8;
super = false;
randomwaveNum = random_range(1, 1667);
depth = 50;
