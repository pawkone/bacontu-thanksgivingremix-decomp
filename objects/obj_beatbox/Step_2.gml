scr_collision();

if (target.sprite_index != spr_player_littledanceydance)
{
    create_particleStatic(spr_genericpoofeffect, x, y, 1, -10);
    instance_destroy();
}
