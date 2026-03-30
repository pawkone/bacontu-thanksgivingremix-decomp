depth = obj_screensizer.depth + 200;
active = false;
graphBorderSize = 2;
graphBack = 
{
    alpha: 0,
    x: 0,
    y: 0
};
bacon = 
{
    index: 0,
    x: -224,
    y: 736,
    smokeIndex: 0
};
screenSprite = -4;
pauseMusic = FMODcreate_event("event:/Music/General/pause");
vinylSND = FMODcreate_event("event:/Sfx/vinyl");
selected = 0;
options = [];
disc = {};
disc.side = 0;
disc.index = 0;
disc.xscale = 1;
disc.rotation = 0;
disc.facing = 1;
buffer = 0;
tipText = "";
playerPalSprite = spr_playerPal;
playerPalIndex = 0;

function doPause()
{
    playeractiveState = obj_player.state;
    playerPalSprite = obj_player.spr_palette;
    playerPalIndex = obj_player.palIndex;
    active = true;
    FMODsetPauseAll(true);
    
    if (sprite_exists(screenSprite))
        sprite_delete(screenSprite);
    
    screenSprite = sprite_create_from_surface(obj_screensizer.gameSurface, 0, 0, obj_screensizer.displayWidth, obj_screensizer.displayHeight, false, false, 0, 0);
    instance_deactivate_all(true);
    instance_activate_object(obj_inputController);
    instance_activate_object(obj_screensizer);
    instance_activate_object(obj_fmod);
    instance_activate_object(obj_shell);
    instance_activate_object(obj_rpc);
    instance_activate_object(obj_savesystem);
    fmod_studio_event_instance_start(pauseMusic);
    fmod_studio_event_instance_set_paused(pauseMusic, false);
    fmod_studio_event_instance_start(vinylSND);
    fmod_studio_event_instance_set_paused(vinylSND, false);
    graphBack.alpha = 0;
    selected = 0;
    disc.side = choose(0, 0, 1);
    disc.index = disc.side;
    
    switch (playeractiveState)
    {
        case states.ski:
            tipText = lang_get_phrase("tip_ski");
            break;
        
        case states.surfing:
            tipText = lang_get_phrase("tip_surf");
            break;
        
        default:
            tipText = "";
            break;
    }
}

function doUnpause()
{
    instance_activate_all();
    FMODsetPauseAll(false);
    fmod_studio_event_instance_stop(pauseMusic, states.normal);
    fmod_studio_event_instance_stop(vinylSND, states.normal);
    
    with (obj_music)
    {
        fmod_studio_event_instance_set_paused(escapeInst, isSecret);
        fmod_studio_event_instance_set_paused(musicInst, isSecret || FMODevent_isplaying(escapeInst));
        fmod_studio_event_instance_set_paused(secretInst, !isSecret);
    }
    
    active = false;
}

var _resume = 
{
    option: "pause_resume",
    
    func: function()
    {
        with (obj_pause)
            doUnpause();
    }
};
var _restart = 
{
    option: "pause_restart",
    
    func: function()
    {
        with (obj_pause)
        {
            doUnpause();
            
            with (obj_music)
            {
                stop_music();
                
                if (FMODevent_isplaying(escapeInst))
                    fmod_studio_event_instance_stop(escapeInst, states.crouch);
            }
            
            with (obj_player)
            {
                generalReset();
                door = "A";
                movespeed = 0;
                vsp = 0;
                hsp = 0;
                state = states.enterdoor;
            }
            
            room_goto(global.resetRoom);
        }
    }
};
var _option = 
{
    option: "pause_options",
    
    func: function()
    {
        FMODevent_oneshot("event:/Sfx/UI/Pause/menuselect");
        instance_create_depth(0, 0, obj_pause.depth - 150, obj_option);
    }
};
var _exitlevel = 
{
    option: "pause_exit",
    
    func: function()
    {
        with (obj_pause)
        {
            doUnpause();
            
            with (obj_player)
            {
                generalReset();
                movespeed = 0;
                vsp = 0;
                hsp = 0;
                state = states.enterdoor;
                door = "NONE";
                room_goto(backtohubRoom);
                
                if (instance_exists(obj_backtohub))
                    instance_destroy(obj_backtohub);
                
                instance_create_depth(x, y, -3, obj_backtohub);
            }
            
            global.level = -4;
            global.resetRoom = -4;
        }
    }
};
_resume.offsetX = 0;
_option.offsetX = 0;
_restart.offsetX = 0;
_exitlevel.offsetX = 0;
array_push(options, _resume);
array_push(options, _option);
array_push(options, _restart);
array_push(options, _exitlevel);
timeUniform = shader_get_uniform(shd_wave, "time");
frequencyUniform = shader_get_uniform(shd_wave, "frequency");
amplitudeUniform = shader_get_uniform(shd_wave, "amplitude");
waveTime = 0;
freq = 0.01;
amp = 0.009;
