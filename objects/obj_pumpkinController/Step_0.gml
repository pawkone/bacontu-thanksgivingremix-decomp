roomname = string_letters(room_get_name(room));
var _darkRooms = string_pos("castle", roomname) > 0;
dark = _darkRooms;
circleSize = approach(circleSize, global.pumpkins.count * 64, 5);
