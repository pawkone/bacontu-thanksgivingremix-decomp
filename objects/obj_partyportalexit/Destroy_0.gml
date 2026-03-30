repeat (12)
    create_particleDebri(spr_disoballDebri, random_range(0, sprite_get_number(spr_disoballDebri)), x, y, 1, -1);

instance_create_depth(x, y, -30, obj_lapWaveEffect);
