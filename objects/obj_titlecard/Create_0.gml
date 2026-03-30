titlecardSprite = lang_get_asset("spr_titlecardMonolith");
titlecardName = 
{
    index: 1,
    x: 0,
    y: 0,
    alpha: 0,
    fadeIn: false
};
fadeAlpha = 0;
fadeIn = true;
scene = 0;
depth = -600;
fadeSurface = surface_create(obj_screensizer.displayWidth, obj_screensizer.displayHeight);
circleSize = 0;
circleSizeSpeed = 0;
ratingAlpha = 0;
FMODevent_oneshot("event:/Music/W1/Monolith Mangrove/titlecard");
