getMenu_input();

if (active)
{
    if (key_jump2 && canProgress)
    {
        dialogStuff[currentDialog].func();
        currentDialog++;
        textVisual = "";
        textLetter = 1;
        alarm[0] = 2;
    }
    
    if (currentDialog > (array_length(dialogStuff) - 1))
        instance_destroy();
}
