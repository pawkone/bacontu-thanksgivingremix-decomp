if (!surface_exists(photoSurf))
    photoSurf = surface_create(200, 200);

var _x = 0 + (surface_get_width(photoSurf) / 2);
var _y = 0 + (surface_get_height(photoSurf) / 2);
surface_set_target(photoSurf);
draw_clear_alpha(c_black, 0);
gpu_set_blendmode_ext(bm_one, bm_zero);
draw_sprite_ext(spr_taunteffectMask, image_index, _x, _y, 1, 1, image_angle, c_white, 1);
gpu_set_blendmode_ext(bm_dest_alpha, bm_zero);
draw_sprite_ext(spr_tauntEffectBackground, photoIndex, _x, _y, 1, 1, image_angle, c_white, 1);
gpu_set_blendmode(bm_normal);
surface_reset_target();
draw_set_alpha(image_alpha);
draw_sprite_ext(spr_taunteffect, image_index, x, y, 1, 1, image_angle, c_white, image_alpha);
draw_surface(photoSurf, x - 100, y - 100);
draw_set_alpha(1);
