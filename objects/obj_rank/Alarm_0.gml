if (textPos < array_length(text))
{
    FMODevent_oneshot("event:/Sfx/Player/punch", obj_screensizer.displayWidth / 2, obj_screensizer.displayHeight / 2);
    shake = 15;
    text[textPos][0] = true;
    textPos++;
    alarm[0] = 40;
}
else
{
    canContinue = true;
}
