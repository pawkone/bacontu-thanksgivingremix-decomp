texturesMax = 0;
draw_flush();
groups = ["Default", "Player_group", "Monolith_group"];
textures = [];

for (var i = 0; i < array_length(groups); i++)
    array_push(textures, texturegroup_get_textures(groups[i]));

lang_init();
texturesMax = array_length(textures);
alarm[0] = 20;
image_speed = 0.35;
blackAlpha = 0;
fadeOut = false;
