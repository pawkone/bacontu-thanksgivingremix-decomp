draw_set_halign(fa_center);
draw_set_font(global.smallnumberfnt);
draw_set_alpha(image_alpha);
draw_text_transformed(x, y, text, image_xscale, image_yscale, 0);
draw_set_alpha(1);
