avocadoLogo = {};
avocadoLogo.size = 1;
avocadoLogo.sprite = avocadoEngine;
avocadoLogo.x = obj_screensizer.displayWidth / 2;
avocadoLogo.y = obj_screensizer.displayHeight + 300;
checkerX = 0;
screenFlash = 1;
whiteBack = 0;
dark = 0;
scene = 0;
obj_player.state = -4;
menus = [];
currentMenu = 0;
selecting = 0;
var baseMenu = [];
array_push(baseMenu, 
{
    name: "Level Select",
    
    func: function()
    {
        obj_avocadoMenu.currentMenu = 1;
        obj_avocadoMenu.selecting = 1;
    }
});
array_push(baseMenu, 
{
    name: "Exit Game",
    
    func: function()
    {
        game_end();
    }
});
var levelSelect = [];
array_push(levelSelect, 
{
    name: "Back",
    
    func: function()
    {
        obj_avocadoMenu.currentMenu = 0;
        obj_avocadoMenu.selecting = 0;
    }
});
array_push(levelSelect, 
{
    name: "Monolith Mangrove",
    
    func: function()
    {
        var _rm = mangrove_1;
        var _dr = "A";
        
        with (obj_player)
        {
            generalReset();
            targetRoom = _rm;
            door = _dr;
            movespeed = 0;
            vsp = 0;
            hsp = 0;
            state = states.enterdoor;
        }
        
        global.level = "forest";
        global.resetRoom = _rm;
        
        if (!instance_exists(obj_fadeout))
            instance_create_depth(0, 0, 0, obj_fadeout);
    }
});
array_push(levelSelect, 
{
    name: "BeakerNDraft_1",
    
    func: function()
    {
        var _rm = forest_1;
        var _dr = "A";
        
        with (obj_player)
        {
            generalReset();
            targetRoom = _rm;
            door = _dr;
            movespeed = 0;
            vsp = 0;
            hsp = 0;
            state = states.enterdoor;
        }
        
        global.level = "forest";
        global.resetRoom = _rm;
        
        if (!instance_exists(obj_fadeout))
            instance_create_depth(0, 0, 0, obj_fadeout);
    }
});
array_push(levelSelect, 
{
    name: "John Gutter 2",
    
    func: function()
    {
        var _rm = test_1;
        var _dr = "A";
        
        with (obj_player)
        {
            generalReset();
            targetRoom = _rm;
            door = _dr;
            movespeed = 0;
            vsp = 0;
            hsp = 0;
            state = states.enterdoor;
        }
        
        global.level = "gutter";
        global.resetRoom = _rm;
        
        if (!instance_exists(obj_fadeout))
            instance_create_depth(0, 0, 0, obj_fadeout);
    }
});
array_push(menus, 
{
    header: "AVOCADO ENGINE - MAIN MENU",
    y: -obj_screensizer.displayHeight * 2,
    menu: baseMenu
});
array_push(menus, 
{
    header: "AVOCADO ENGINE - LEVEL SELECT",
    y: -obj_screensizer.displayHeight * 2,
    menu: levelSelect
});
cursorY = -100;
cursorX = -100;
