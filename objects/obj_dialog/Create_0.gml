dialogStuff = [];
currentDialog = 0;
active = false;

addDialog = function(arg0, arg1, arg2 = function()
{
})
{
    var q = 
    {
        portrait: arg0,
        text: arg1,
        func: arg2
    };
    array_push(dialogStuff, q);
};

textVisual = "";
textLetter = 1;
canProgress = false;
