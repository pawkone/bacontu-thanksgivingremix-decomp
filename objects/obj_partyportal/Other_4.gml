if (ds_list_find_index(global.saveroom, id) != -1)
    instance_destroy();

if (place_meeting(x, y, obj_doorA))
    targetDoor = "A";

if (place_meeting(x, y, obj_doorB))
    targetDoor = "B";

if (place_meeting(x, y, obj_doorC))
    targetDoor = "C";

if (place_meeting(x, y, obj_doorD))
    targetDoor = "D";

if (place_meeting(x, y, obj_doorE))
    targetDoor = "E";

if (place_meeting(x, y, obj_doorF))
    targetDoor = "F";

if (place_meeting(x, y, obj_doorG))
    targetDoor = "G";

if (place_meeting(x, y, obj_doorH))
    targetDoor = "H";

if (place_meeting(x, y, obj_doorS))
    targetDoor = "S";
