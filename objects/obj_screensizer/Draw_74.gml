if (!surface_exists(gameSurface))
    gameSurface = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);

surface_set_target(gameSurface);
draw_clear_alpha(c_black, 0);
gpu_set_blendenable(false);
draw_clear_alpha(c_black, 0);
gpu_set_blendenable(false);
draw_surface(application_surface, 0, 0);
gpu_set_blendenable(true);
