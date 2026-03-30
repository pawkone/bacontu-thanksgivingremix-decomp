global.patternColors = shader_get_sampler_index(shd_pattern, "tex_setColors");
global.patternUVs = shader_get_uniform(shd_pattern, "tex_colorsUV");
global.patternTexel = shader_get_uniform(shd_pattern, "tex_height");

function pattern_draw(_sprite, _frame, _x, _y, _xscale, _yscale, _angle, _blend, _alpha, _patternspr = global.patternSpr, _patterncol = spr_playerPatColors, _palettespr = obj_player.spr_palette, _paletteindex = obj_player.palIndex)
{
    if (_patternspr != -1)
    {
        var _surf = surface_create(sprite_get_width(_sprite), sprite_get_height(_sprite));
        surface_set_target(_surf);
        draw_clear_alpha(c_black, 0);
        shader_reset();
        shader_set(shd_pattern);
        var q = sprite_get_texture(spr_playerPatColors, 0);
        var p = sprite_get_uvs(spr_playerPatColors, 0);
        var s = texture_get_texel_height(q);
        texture_set_stage(global.patternColors, q);
        shader_set_uniform_f(global.patternUVs, p[0], p[1], p[2], p[3]);
        shader_set_uniform_f(global.patternTexel, s);
        draw_sprite_ext(_sprite, _frame, sprite_get_xoffset(_sprite), sprite_get_yoffset(_sprite), 1, 1, _angle * _xscale, c_white, 1);
        shader_reset();
        gpu_set_blendmode(bm_min);
        pal_swap_set(_palettespr, _paletteindex, false);
        draw_sprite_tiled_ext(_patternspr, 0, 0, 0, _xscale, 1, c_white, 1);
        shader_reset();
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
        draw_surface_ext(_surf, _x - (sprite_get_xoffset(_sprite) * _xscale), _y - (sprite_get_yoffset(_sprite) * _yscale), _xscale, _yscale, 0, _blend, _alpha);
        surface_free(_surf);
    }
}
