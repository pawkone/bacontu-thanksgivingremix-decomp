global.kettleFont = font_add_sprite_ext(font_kettle, "0123456789", 1, 0);
global.comboFont = font_add_sprite_ext(font_combo, "1234567890", 1, 0);
global.creditsfont = font_add_sprite_ext(spr_creditsfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.:!0123456789?'\"ÁÉÍÓÚáéíóú_-[]▼()&#风雨廊桥전태양*яиБжидГзвбнль↑↓←→⇧⌃␣⎋", 1, 2);
global.bigfont = font_add_sprite_ext(spr_bigfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡¿?.1234567890:ÁÄÃÀÂÉÈÊËÍÌÎÏÓÖÕÔÒÚÙÛÜÇ+", true, 0);
global.smallfont = font_add_sprite_ext(spr_smallfont, "abcdefghijklmnopqrstuvwxyz1234567890.:!?", 1, 0);
global.npcfont = font_add_sprite_ext(spr_npcfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZabcdefghijklmnñopqrstuvwxyz!¡,.:0123456789'?¿-áäãàâæéèêëíîïóöõôúùûüÿŸÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇç", true, 2);
global.smallnumberfnt = font_add_sprite_ext(spr_smallnumber, "1234567890-+", 1, 0);
global.username = "guest";
room_goto(rm_intro);
randomize();
global.gSocket = irandom_range(1, 166667);
global.debug = false;
global.showcollisions = true;
ini_open(working_directory + "options.ini");
global.MasterVolume = ini_read_real("General", "Master", 1);
global.MusicVolume = ini_read_real("General", "Music", 1);
global.SfxVolume = ini_read_real("General", "Sfx", 0.7);
global.AmbianceVolume = ini_read_real("General", "Ambiance", 1);
global.Fullscreen = ini_read_real("General", "Fullscreen", 0);

switch (global.Fullscreen)
{
    case 0:
        break;
    
    case 1:
        window_set_fullscreen(true);
        break;
    
    case 2:
        window_enable_borderless_fullscreen(true);
        window_set_fullscreen(true);
        break;
}

global.vsync = ini_read_real("General", "Vsync", false);
global.hide_hud = ini_read_real("Visual", "showHud", false);
global.unfocus_mute = ini_read_real("General", "Unfocus Mute", true);
global.dirSuper = ini_read_real("General", "dirSuper", true);
global.dirGround = ini_read_real("General", "dirGround", true);
global.windowSize = ini_read_real("General", "Windowsize", 1);
global.texFilter = ini_read_real("General", "texFilter", false);
gpu_set_tex_filter(global.texFilter);
var res = [[480, 270], [960, 540], [1024, 576], [1280, 720], [1600, 900], [1920, 1080]];
window_set_size(res[global.windowSize][0], res[global.windowSize][1]);
window_center();
ini_close();
global.saveFile = working_directory + "/saves/save1.ini";
ini_open(global.saveFile);
global.cutscenes = {};
global.cutscenes.miltonIntro = ini_read_real("Cutscenes", "miltonIntro", false);
ini_close();
