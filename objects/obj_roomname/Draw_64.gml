var _xx = (obj_screensizer.displayWidth / 2) + wave(-3, 3, 3, 0);
var _yy = textY;
draw_sprite(spr_roomname, 0, _xx, _yy);
draw_set_font(global.smallfont);
draw_set_halign(fa_center);
draw_text(_xx + 5, _yy + 12, string_lower(text));
