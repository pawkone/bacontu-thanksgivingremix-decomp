if (string_length(textVisual) < string_length(lang_get_phrase(dialogStuff[currentDialog].text)))
{
    canProgress = false;
    var letter = string_char_at(lang_get_phrase(dialogStuff[currentDialog].text), textLetter);
    textVisual += letter;
    textLetter++;
    alarm[0] = 2;
    FMODevent_oneshot("event:/Sfx/UI/Pause/step");
}
else
{
    canProgress = true;
}
