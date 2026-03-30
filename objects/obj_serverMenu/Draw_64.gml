if (menu == 0)
{
    var xx = obj_screensizer.displayWidth / 2;
    var opt = menus[currentmenu];
    var yy = (obj_screensizer.displayHeight / 2) - (48 * (array_length(opt) - 2));
    
    for (var i = 0; i < array_length(opt); i++)
    {
        var q = opt[i];
        var _col = (selected == i) ? 16777215 : 8421504;
        draw_set_font(global.bigfont);
        draw_set_color(_col);
        draw_set_halign(fa_center);
        draw_textEX(xx, yy, q[1]);
        yy += 48;
    }
}

draw_set_font(global.creditsfont);
draw_set_halign(fa_center);

if (menu == 1)
{
    draw_textEX(obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2, "[wave]Enter the IP");
    draw_textEX(obj_screensizer.displayWidth / 2, (obj_screensizer.displayHeight / 2) + 32, string("[wave]{0}", textInput));
}

if (menu == 2)
{
    draw_textEX(obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2, "[wave]Enter the Port");
    draw_textEX(obj_screensizer.displayWidth / 2, (obj_screensizer.displayHeight / 2) + 32, string("[wave]{0}", textInput));
}

draw_set_color(c_white);
