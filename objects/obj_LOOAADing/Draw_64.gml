draw_sprite(spr_loadingBacon, 1, 480, 270);
draw_sprite_part(spr_loadingBacon, 0, 0, 0, (1 - (array_length(textures) / texturesMax)) * sprite_get_width(spr_loadingBacon), sprite_get_height(spr_loadingBacon), 480 - (sprite_get_width(spr_loadingBacon) / 2), 270 - (sprite_get_height(spr_loadingBacon) / 2));
draw_set_alpha(blackAlpha);
draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_color(c_white);
draw_set_alpha(1);

if (fadeOut)
    blackAlpha += 0.05;

if (blackAlpha >= 1)
    room_goto(initObject);

draw_set_alpha(1);
