image_xscale = enemy_inst.xscale;
x = enemy_inst.x;
y = enemy_inst.y;

if (!instance_exists(enemy_inst))
    instance_destroy();
