x = 0;
y = 0;
depth = 15;
ds_list_clear(global.saveroom);
ds_list_clear(global.escaperoom);
ds_list_clear(global.followers);
canContinue = false;
fadeAlpha = 0;
cutscenePart = 0;
obj_player.state = -4;
showRank = false;
showRankText = false;
rankIndex = 0;

with (obj_music)
{
    stop_music();
    
    if (FMODevent_isplaying(escapeInst))
        fmod_studio_event_instance_stop(escapeInst, states.crouch);
}

global.escape = 
{
    active: false,
    timer: 7200,
    party: false
};
FMODstopAll();
music = FMODcreate_event("event:/Music/General/ranks");
var _rankIndex = 0;

if (global.collect >= global.Crank)
    _rankIndex = 1;

if (global.collect >= global.Brank)
    _rankIndex = 2;

if (global.collect >= global.Arank)
    _rankIndex = 3;

if (global.collect >= global.Srank)
    _rankIndex = 4;

fmod_studio_event_instance_set_parameter_by_name(music, "state", _rankIndex);
fmod_studio_event_instance_start(music);
rankspr = spr_rankD;
ranktextSpr = lang_get_asset("spr_rankD_text");
var _col = 7884848;
var _col2 = 4729105;

switch (_rankIndex)
{
    case 0:
        rankspr = spr_rankD;
        ranktextSpr = lang_get_asset("spr_rankD_text");
        _col = 7884848;
        _col2 = 4729105;
        break;
    
    case 1:
        rankspr = spr_rankC;
        ranktextSpr = lang_get_asset("spr_rankC_text");
        _col = 4771936;
        _col2 = 28672;
        break;
    
    case 2:
        rankspr = spr_rankB;
        ranktextSpr = lang_get_asset("spr_rankB_text");
        _col = 16295984;
        _col2 = 11030568;
        break;
    
    case 3:
        rankspr = spr_rankA;
        ranktextSpr = lang_get_asset("spr_rankA_text");
        _col = 248;
        _col2 = 80;
        break;
    
    case 4:
        rankspr = spr_rankS;
        ranktextSpr = lang_get_asset("spr_rankS_text");
        _col = 37088;
        _col2 = 10392;
        break;
}

uniform1 = shader_get_uniform(shd_fullshade, "lightest");
uniform2 = shader_get_uniform(shd_fullshade, "darkest");
rankSurf = -4;
col = [color_get_red(_col) / 255, color_get_green(_col) / 255, color_get_blue(_col) / 255];
col2 = [color_get_red(_col2) / 255, color_get_green(_col2) / 255, color_get_blue(_col2) / 255];
colorAlpha = 0;
ranktimer = 180;
shake = 0;
textPos = 0;
text = [];
array_push(text, [false, string("SCORE: {0}", global.collect)]);
array_push(text, [false, string("TIME: {0}", calculateTime(global.level_timer))]);
array_push(text, [false, "DAMAGE: DUMMY"]);
array_push(text, [false, "HIGHEST COMBO: DUMMY"]);
array_push(text, [false, "######PRESS [J] TO CONTINUE"]);
