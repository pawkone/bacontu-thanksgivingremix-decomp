if (show == false)
    textY = approach(textY, -64, 2);
else
    textY = approach(textY, 27, 10);

visible = text != "";

switch (room)
{
    default:
        text = "";
        break;
    
    case hotel_entrance:
    case hotel_reception:
    case hotel_1:
    case mangrove_1:
    case mangrove_2:
    case mangrove_3:
    case mangrove_4:
    case mangrove_5:
    case mangrove_secret1:
    case mangrove_secret2:
    case mangrove_6:
    case mangrove_7:
    case mangrove_8:
    case mangrove_9:
    case mangrove_10:
    case mangrove_11:
    case mangrove_12:
    case mangrove_13:
    case mangrove_lap:
    case beer_1:
    case beer_2:
    case beer_3:
        text = lang_get_phrase(string("roomname_{0}", room_get_name(room)));
        break;
}
