add_saveVariable("Game", "Palette", obj_player.palIndex, global.saveFile);
add_saveVariable("Game", "Pattern", sprite_get_name(global.patternSpr), global.saveFile);
push_saveVariables();
