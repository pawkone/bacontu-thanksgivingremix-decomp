var n_id = ds_map_find_value(async_load, "id");

if (n_id == global.server)
{
    var t = ds_map_find_value(async_load, "type");
    
    switch (t)
    {
        case 1:
            var sock = ds_map_find_value(async_load, "socket");
            ds_list_add(connections, sock);
            break;
        
        case 2:
            var sock = ds_map_find_value(async_load, "socket");
            
            with (obj_onlinePlayer)
            {
                if (socket == sock)
                {
                    obj_server.create_notifAsync(string("{0} has disconnected!", name), 65535);
                    instance_destroy();
                    break;
                }
            }
            
            ds_list_delete(connections, sock);
            break;
    }
}

if (ds_map_find_value(async_load, "type") == 3)
{
    var buff = ds_map_find_value(async_load, "buffer");
    
    if (buffer_exists(buff))
    {
        buffer_seek(buff, buffer_seek_start, 0);
        var p = buffer_read(buff, buffer_string);
        var q = json_parse(p);
        
        switch (q.type)
        {
            case states.normal:
                ds_list_add(notifs, q);
                break;
            
            case states.turn:
                ds_list_clear(connections);
                
                for (var i = 0; i < array_length(q.con); i++)
                    ds_list_add(connections, q.con[i]);
                
                break;
            
            case states.crouch:
                if (q.onlineID == onlineID)
                    exit;
                
                var _found = false;
                var _objPl = -4;
                
                for (var i = 0; i < instance_number(obj_onlinePlayer); i++)
                {
                    var obj = instance_find(obj_onlinePlayer, i);
                    
                    if (obj.onlineID == q.onlineID)
                    {
                        _found = true;
                        _objPl = obj;
                    }
                }
                
                if (!_found)
                {
                    _objPl = instance_create_depth(0, 0, 0, obj_onlinePlayer);
                    _objPl.onlineID = q.onlineID;
                }
                
                with (_objPl)
                {
                    currentRoom = q.room;
                    x = q.x;
                    y = q.y;
                    image_index = q.image_index;
                    sprite_index = q.sprite_index;
                    image_alpha = q.image_alpha;
                    image_blend = q.image_blend;
                    xscale = q.xscale;
                    state = q.state;
                    name = q.name;
                    depth = q.depth;
                    flash = q.flash;
                    spr_palette = q.spr_palette;
                    palIndex = q.palIndex;
                    breakdanceheld = q.breakdanceheld;
                    breakdancespeed = q.breakdancespeed;
                    socket = q.onlineID;
                }
                
                break;
            
            case states.move:
                var v = q.vars;
                
                if (q.room != room || q.onlineID == onlineID)
                    exit;
                
                var names = struct_get_names(v);
                var instance = instance_create_depth(q.x, q.y, q.depth, q.obj);
                instance.onlineID = q.onlineID;
                
                for (var i = 0; i < array_length(names); i++)
                    variable_instance_set(instance, names[i], variable_struct_get(v, names[i]));
                
                break;
            
            case states.mach2:
                if (room == q.room)
                    ds_list_add(obj_particleSystem.particles, q.particle);
                
                break;
            
            case states.jump:
                network_destroy(global.client);
                show_message("Server has closed!");
                obj_player.targetRoom = "A";
                room_goto(serverMenuShit);
                instance_destroy();
                
                with (obj_onlinePlayer)
                    instance_destroy();
                
                break;
            
            case states.mach3:
                if (room == q.room)
                    ds_list_add(obj_afterimageSystem.afterimages, q.after);
                
                break;
            
            case states.machturn:
                if (room == q.room)
                {
                    var _inst = FMODcreate_event(q.snd);
                    fmod_studio_event_instance_start(_inst);
                    
                    if (!is_undefined(q.x) && !is_undefined(q.y))
                        FMODSet3dPos(_inst, q.x, q.y);
                    
                    fmod_studio_event_instance_release(_inst);
                }
                
                break;
        }
        
        if (global.client == -4)
        {
            var _serverBuff = buffer_create(1, buffer_grow, 1);
            buffer_seek(_serverBuff, buffer_seek_start, 0);
            buffer_write(_serverBuff, buffer_string, p);
            self.network_send_packetServ(_serverBuff, buffer_tell(_serverBuff));
            buffer_delete(_serverBuff);
        }
    }
}
