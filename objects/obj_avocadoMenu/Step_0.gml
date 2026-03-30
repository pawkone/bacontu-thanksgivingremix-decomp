checkerX -= 0.5;
getMenu_input();

switch (scene)
{
    case 0:
        for (var i = 0; i < array_length(menus); i++)
        {
            var q = menus[i];
            q.y = lerp(q.y, -obj_screensizer.displayHeight * 2, 0.05);
        }
        
        cursorY = lerp(cursorY, -100, 0.1);
        cursorX = lerp(cursorX, -100, 0.1);
        whiteBack = approach(whiteBack, 0, 0.03);
        screenFlash = lerp(screenFlash, 0, 0.01);
        avocadoLogo.x = lerp(avocadoLogo.x, obj_screensizer.displayWidth / 2, 0.05);
        avocadoLogo.y = lerp(avocadoLogo.y, (obj_screensizer.displayHeight / 2) + wave(-1, 1, 4, 0), 0.05);
        avocadoLogo.size = lerp(avocadoLogo.size, 0.67, 0.05);
        
        if (key_jump2)
        {
            avocadoLogo.size = 0.6;
            scene = -1;
            screenFlash = 1;
            currentMenu = 0;
            selecting = 0;
        }
        
        break;
    
    case -1:
        screenFlash = lerp(screenFlash, 0, 0.05);
        avocadoLogo.x = lerp(avocadoLogo.x, obj_screensizer.displayWidth / 2, 0.05);
        avocadoLogo.y = lerp(avocadoLogo.y, obj_screensizer.displayHeight / 2, 0.05);
        avocadoLogo.size = lerp(avocadoLogo.size, 0.67, 0.1);
        
        if (avocadoLogo.size >= 0.667)
            scene = -2;
        
        break;
    
    case -2:
        dark = approach(dark, 1, 0.03);
        
        if (dark >= 1)
        {
            var _rm = hotel_entrance;
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
            
            global.level = -4;
            global.resetRoom = _rm;
            
            if (!instance_exists(obj_fadeout))
                instance_create_depth(0, 0, 0, obj_fadeout);
        }
        
        break;
    
    case 1:
        screenFlash = lerp(screenFlash, 0, 0.05);
        avocadoLogo.x = lerp(avocadoLogo.x, obj_screensizer.displayWidth / 2, 0.05);
        avocadoLogo.y = lerp(avocadoLogo.y, obj_screensizer.displayHeight / 2, 0.05);
        avocadoLogo.size = lerp(avocadoLogo.size, 0.67, 0.1);
        
        if (avocadoLogo.size >= 0.667)
            scene = 2;
        
        break;
    
    case 2:
        whiteBack = approach(whiteBack, 0.67, 0.03);
        avocadoLogo.x = lerp(avocadoLogo.x, 128, 0.1);
        avocadoLogo.y = lerp(avocadoLogo.y, (obj_screensizer.displayHeight - 50) + wave(-1, 1, 4, 0), 0.1);
        avocadoLogo.size = lerp(avocadoLogo.size, 0.3, 0.1);
        
        for (var i = 0; i < array_length(menus); i++)
        {
            var q = menus[i];
            q.y = lerp(q.y, (currentMenu == i) ? 0 : (-obj_screensizer.displayHeight * 2), 0.2);
        }
        
        var move = key_down2 - key_up2;
        
        if (move != 0)
            selecting += move;
        
        selecting = clamp(selecting, 0, array_length(menus[currentMenu].menu) - 1);
        
        if (key_jump2)
            menus[currentMenu].menu[selecting].func();
        
        if (key_slap2)
            scene = 0;
        
        break;
}
