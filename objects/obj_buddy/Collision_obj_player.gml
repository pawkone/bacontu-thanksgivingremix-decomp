global.combo.timer = 60;
obj_player.super = true;
obj_player.flash = true;
instance_create_depth(x, y, -100, obj_whiteflash);
instance_destroy();
