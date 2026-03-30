global.language = "english";
global.langMapWord = ds_map_create();
global.langMapArt = ds_map_create();

function lang_init()
{
    var _generalPath = "lang/";
    var _textFile = string("{0}/{1}/text.txt", _generalPath, global.language);
    var _json = json_parse(loadString(_textFile));
    var _jsonNames = variable_struct_get_names(_json);
    
    for (var i = 0; i < array_length(_jsonNames); i++)
        ds_map_add(global.langMapWord, _jsonNames[i], variable_struct_get(_json, _jsonNames[i]));
    
    _textFile = string("{0}/{1}/art.txt", _generalPath, global.language);
    _json = json_parse(loadString(_textFile));
    _jsonNames = variable_struct_get_names(_json);
    
    for (var i = 0; i < array_length(_jsonNames); i++)
    {
        var q = variable_struct_get(_json, _jsonNames[i]);
        var _spritePath = string("{0}/{1}/{2}", _generalPath, global.language, q.path);
        ds_map_add(global.langMapArt, _jsonNames[i], sprite_add_gif(_spritePath, q.xorigin, q.yorigin));
    }
}

function lang_get_phrase(_string)
{
    if (ds_map_exists(global.langMapWord, _string))
        return ds_map_find_value(global.langMapWord, _string);
    else
        return _string;
}

function lang_get_asset(_string)
{
    if (ds_map_exists(global.langMapArt, _string))
        return ds_map_find_value(global.langMapArt, _string);
    else
        return -1;
}
