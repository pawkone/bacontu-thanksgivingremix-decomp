global.gif_std_haxe_type_markerValue = [];
(function()
{
    global.mt_gif_reader = new gif_std_haxe_class(-1, "gif_reader");
    global.mt_gif_frame = new gif_std_haxe_class(-1, "gif_frame");
    global.mt_gif_drawer = new gif_std_haxe_class(-1, "gif_drawer");
    global.mt_gif_raw_reader = new gif_std_haxe_class(-1, "gif_raw_reader");
    global.mt_format_gif_block = new gif_std_haxe_enum(-1, "format_gif_block");
    global.mt_format_gif_extension = new gif_std_haxe_enum(-1, "format_gif_extension");
    global.mt_format_gif_application_extension = new gif_std_haxe_enum(-1, "format_gif_application_extension");
    global.mt_format_gif_version = new gif_std_haxe_enum(-1, "format_gif_version");
    global.mt_format_gif_disposal_method = new gif_std_haxe_enum(-1, "format_gif_disposal_method");
    global.mt_gif_std_haxe_class = new gif_std_haxe_class(-1, "gif_std_haxe_class");
    global.mt_gif_std_haxe_enum = new gif_std_haxe_class(-1, "gif_std_haxe_enum");
    global.mt_gif_std_haxe_io_Bytes = new gif_std_haxe_class(-1, "gif_std_haxe_io_Bytes");
    global.mt_gif_std_haxe_io_Output = new gif_std_haxe_class(-1, "gif_std_haxe_io_Output");
    global.mt_gif_std_haxe_io_BytesOutput = new gif_std_haxe_class(-1, "gif_std_haxe_io_BytesOutput");
    global.mt_gif_std_haxe_io_BytesOutput.superClass = global.mt_gif_std_haxe_io_Output;
})();

function gif_std_enum_toString()
{
    return gif_std_Std_stringify(self);
}

function gif_std_enum_getIndex()
{
    return __enumIndex__;
}

function gif_reader(arg0, arg1, arg2, arg3, arg4) constructor
{
    static frames = undefined;
    static fin_frame_count = undefined;
    static width = undefined;
    static height = undefined;
    static loops = undefined;
    static xorig = undefined;
    static yorig = undefined;
    static buffer = undefined;
    static owns_buffer = undefined;
    static sprite = undefined;
    static frame_delays = undefined;
    static frame_sprites = undefined;
    
    static destroy = function()
    {
        var __g = 0;
        var __g1 = self.frames;
        
        while (__g < array_length(__g1))
        {
            var _frame = __g1[__g];
            __g++;
            _frame.destroy();
        }
        
        if (self.owns_buffer && self.buffer != -1)
        {
            buffer_delete(self.buffer);
            self.buffer = -1;
        }
        
        if (self.drawer != undefined)
            self.drawer.destroy();
    };
    
    static reader = undefined;
    static info = undefined;
    static gce = undefined;
    static global_color_table = undefined;
    static current_frame = undefined;
    static set_delay = undefined;
    static drawer = undefined;
    
    static start = function()
    {
        self.reader = new gif_raw_reader(self.buffer);
        self.info = self.reader.read(false);
        self.width = self.info.logicalScreenDescriptor.width;
        self.height = self.info.logicalScreenDescriptor.height;
        
        if (self.info.globalColorTable != undefined)
            self.global_color_table = gif_loader_tools_color_table_to_vector(self.info.globalColorTable, self.info.logicalScreenDescriptor.globalColorTableSize);
    };
    
    static read_frame = function(arg0)
    {
        var _gf = new gif_frame();
        var _transparentIndex = -1;
        
        if (self.gce != undefined)
        {
            _gf.delay = self.gce.delay;
            
            if (self.gce.hasTransparentColor)
                _transparentIndex = self.gce.transparentIndex;
            
            switch (self.gce.disposalMethod.__enumIndex__)
            {
                case 2:
                    _gf.disposal_method = 1;
                    break;
                
                case 3:
                    _gf.disposal_method = 2;
                    break;
            }
        }
        
        _gf.x = arg0.x;
        _gf.y = arg0.y;
        _gf.width = arg0.width;
        _gf.height = arg0.height;
        var _colorTable = self.global_color_table;
        
        if (arg0.colorTable != undefined)
            _colorTable = gif_loader_tools_color_table_to_vector(arg0.colorTable, arg0.localColorTableSize);
        
        var _fWidth = arg0.width;
        var _fHeight = arg0.height;
        var _sf = surface_create(_fWidth, _fHeight);
        var _pxData = arg0.pixels.b;
        var _buf = buffer_create(arg0.width * arg0.height * 4, buffer_fixed, 1);
        var _i = 0;
        var __g1 = array_length(arg0.pixels.b);
        
        while (_i < __g1)
        {
            var _col = _pxData[_i];
            
            if (_col == _transparentIndex)
                buffer_write(_buf, buffer_s32, 0);
            else
                buffer_write(_buf, buffer_s32, _colorTable[_col]);
            
            _i++;
        }
        
        _gf.buffer = _buf;
        buffer_set_surface(_buf, _sf, 0);
        self.gce = undefined;
        array_push(self.frames, _gf);
        self.next_frame = _gf;
    };
    
    static last_action = undefined;
    
    static get_last_action = function()
    {
        return self.last_action;
    };
    
    static get_last_action_name = function()
    {
        return gif_reader_get_action_name(self.last_action);
    };
    
    static get_frame_count = function()
    {
        return self.fin_frame_count;
    };
    
    static get_sprite = function()
    {
        return self.sprite;
    };
    
    static found_eof = undefined;
    static next_frame = undefined;
    
    static next = function()
    {
        if (self.found_eof)
            return false;
        
        var _frame = self.next_frame;
        
        if (_frame != undefined)
        {
            self.next_frame = undefined;
            
            if (self.drawer == undefined)
                self.drawer = new gif_drawer(self);
            
            self.drawer.draw(_frame);
            var _fdelay = _frame.delay;
            var _tmp = self.frame_delays;
            
            if (_tmp != undefined)
                array_push(_tmp, _fdelay);
            
            if (!self.set_delay && _fdelay > 0 && self.frame_sprites == undefined)
            {
                self.set_delay = true;
                sprite_set_speed(self.sprite, 100 / _fdelay, 0);
            }
            
            self.last_action = states.mach3;
            self.fin_frame_count += 1;
            return true;
        }
        
        var _block = self.reader.read_next(self.info.blocks);
        
        switch (_block.__enumIndex__)
        {
            case 0:
                self.read_frame(_block.frame);
                self.last_action = states.jump;
                break;
            
            case 1:
                var __g = _block.extension;
                
                switch (__g.__enumIndex__)
                {
                    case 3:
                        var __g1 = __g.ext;
                        
                        if (__g1.__enumIndex__ == 0)
                        {
                            var _n = __g1.loops;
                            self.loops = _n;
                            self.last_action = states.crouch;
                        }
                        else
                        {
                            self.last_action = states.crouch;
                        }
                        
                        break;
                    
                    case 0:
                        self.gce = __g.gce;
                        self.last_action = states.mach2;
                        break;
                    
                    default:
                        self.last_action = states.crouch;
                }
                
                break;
            
            case 2:
                self.last_action = states.machslide;
                self.found_eof = true;
                return false;
        }
        
        return true;
    };
    
    static next_few = function(arg0)
    {
        var _till = current_time + arg0;
        var _cont;
        
        do
            _cont = self.next();
        until (!(_cont && current_time < _till));
        
        return _cont;
    };
    
    static finish = function()
    {
        self.found_eof = true;
        self.destroy();
        return self.sprite;
    };
    
    static __class__ = global.mt_gif_reader;
    
    self.next_frame = undefined;
    self.found_eof = false;
    self.last_action = states.normal;
    self.drawer = undefined;
    self.set_delay = false;
    self.current_frame = -1;
    self.global_color_table = undefined;
    self.gce = undefined;
    self.info = undefined;
    self.sprite = -1;
    self.owns_buffer = false;
    self.loops = -1;
    self.height = 0;
    self.width = 0;
    self.fin_frame_count = 0;
    self.frames = [];
    self.buffer = arg0;
    self.xorig = arg1;
    self.yorig = arg2;
    self.frame_delays = arg3;
    self.frame_sprites = arg4;
}

function gif_reader_get_action_name(arg0)
{
    switch (arg0)
    {
        case states.normal:
            return "None";
        
        case states.crouch:
            return "Meta";
        
        case states.jump:
            return "Frame";
        
        case states.mach2:
            return "GCE";
        
        case states.mach3:
            return "Render";
        
        case states.machslide:
            return "EOF";
    }
}

function sprite_add_gif_buffer(arg0, arg1, arg2, arg3, arg4)
{
    var _gif = new gif_reader(arg0, arg1, arg2, arg3, arg4);
    _gif.start();
    
    while (_gif.next())
    {
    }
    
    return _gif.finish();
}

function sprite_add_gif_buffer_start(arg0, arg1, arg2, arg3, arg4)
{
    var _gif = new gif_reader(arg0, arg1, arg2, arg3, arg4);
    _gif.start();
    return _gif;
}

function sprite_add_gif(arg0, arg1, arg2, arg3, arg4)
{
    var _buf = buffer_load(arg0);
    var _spr = sprite_add_gif_buffer(_buf, arg1, arg2, arg3, arg4);
    buffer_delete(_buf);
    return _spr;
}

function sprite_add_gif_start(arg0, arg1, arg2, arg3, arg4)
{
    var _buf = buffer_load(arg0);
    var _gif = sprite_add_gif_buffer_start(_buf, arg1, arg2, arg3, arg4);
    _gif.owns_buffer = true;
    return _gif;
}

function gif_frame() constructor
{
    static delay = undefined;
    static buffer = undefined;
    static width = undefined;
    static height = undefined;
    static disposal_method = undefined;
    
    static destroy = function()
    {
        if (self.buffer != -1)
        {
            buffer_delete(self.buffer);
            self.buffer = -1;
        }
    };
    
    static __class__ = global.mt_gif_frame;
    
    x = undefined;
    y = undefined;
    self.disposal_method = 0;
    self.buffer = -1;
    self.delay = 0;
}

function gif_loader_tools_color_table_to_vector(arg0, arg1)
{
    var _p = 0;
    var _a = 255;
    var _vec = array_create(arg1, undefined);
    
    for (var _i = 0; _i < arg1; _i++)
    {
        var _r = arg0.b[_p];
        var _g = arg0.b[_p + 1];
        var _b = arg0.b[_p + 2];
        var _val = (_a << 24) | (_b << 16) | (_g << 8) | _r;
        _vec[_i] = _val;
        _p += 3;
    }
    
    return _vec;
}

function gif_drawer(arg0) constructor
{
    static restore_buf = undefined;
    static surface = undefined;
    static gif = undefined;
    
    static destroy = function()
    {
        if (self.restore_buf != -1)
        {
            buffer_delete(self.restore_buf);
            self.restore_buf = -1;
        }
        
        if (surface_exists(self.surface))
        {
            surface_free(self.surface);
            self.surface = -1;
        }
    };
    
    static draw = function(arg0)
    {
        var _sprite1 = self.gif.sprite;
        
        if (!surface_exists(self.surface))
        {
            var _sf = surface_create(self.gif.width, self.gif.height);
            surface_set_target(_sf);
            draw_clear_alpha(c_white, 0);
            
            if (_sprite1 != -1)
                draw_sprite(_sprite1, sprite_get_number(_sprite1) - 1, self.gif.xorig, self.gif.yorig);
            
            surface_reset_target();
            self.surface = _sf;
        }
        
        if (arg0.disposal_method == 2)
        {
            if (self.restore_buf == -1)
                self.restore_buf = buffer_create(self.gif.width * self.gif.height * 4, buffer_fixed, 1);
            
            buffer_get_surface(self.restore_buf, self.surface, 0);
        }
        
        var _frameSurf = surface_create(arg0.width, arg0.height);
        buffer_set_surface(arg0.buffer, _frameSurf, 0);
        surface_set_target(self.surface);
        draw_surface(_frameSurf, arg0.x, arg0.y);
        var __this = self.surface;
        surface_reset_target();
        surface_free(_frameSurf);
        
        if (self.gif.frame_sprites != undefined)
        {
            var _sf = self.surface;
            var _ox = self.gif.xorig;
            var _oy = self.gif.yorig;
            _sprite1 = sprite_create_from_surface(_sf, 0, 0, surface_get_width(_sf), surface_get_height(_sf), false, false, _ox, _oy);
            array_push(self.gif.frame_sprites, _sprite1);
            self.gif.sprite = _sprite1;
        }
        else if (_sprite1 == -1)
        {
            var _sf = self.surface;
            var _ox = self.gif.xorig;
            var _oy = self.gif.yorig;
            _sprite1 = sprite_create_from_surface(_sf, 0, 0, surface_get_width(_sf), surface_get_height(_sf), false, false, _ox, _oy);
            self.gif.sprite = _sprite1;
        }
        else
        {
            var _sf = self.surface;
            sprite_add_from_surface(_sprite1, _sf, 0, 0, surface_get_width(_sf), surface_get_height(_sf), false, false);
        }
        
        switch (arg0.disposal_method)
        {
            case 2:
                buffer_set_surface(self.restore_buf, self.surface, 0);
                break;
            
            case 1:
                surface_set_target(self.surface);
                var _mode = 3;
                gpu_set_blendmode(_mode);
                draw_sprite_stretched(global.gif_drawer_white32, 0, arg0.x, arg0.y, arg0.width, arg0.height);
                _mode = 0;
                gpu_set_blendmode(_mode);
                __this = self.surface;
                surface_reset_target();
                break;
        }
    };
    
    static __class__ = global.mt_gif_drawer;
    
    self.surface = -1;
    self.restore_buf = -1;
    
    if (global.gif_drawer_white32 == -1)
        gif_drawer_init_white32();
    
    self.gif = arg0;
}

function gif_drawer_init_white32()
{
    var _ws = surface_create(32, 32);
    surface_set_target(_ws);
    draw_clear(c_white);
    surface_reset_target();
    global.gif_drawer_white32 = sprite_create_from_surface(_ws, 0, 0, surface_get_width(_ws), surface_get_height(_ws), false, false, 0, 0);
    surface_free(_ws);
}

function gif_raw_reader(arg0) constructor
{
    static i = undefined;
    
    static read_string = function(arg0)
    {
        var _buf = global.gif_raw_reader_read_string_tmp_buf;
        
        if (_buf == -1)
        {
            _buf = buffer_create(arg0 + 1, buffer_fixed, 1);
            global.gif_raw_reader_read_string_tmp_buf = _buf;
        }
        else if (buffer_get_size(_buf) <= arg0)
        {
            buffer_resize(_buf, arg0 + 1);
        }
        
        buffer_poke(_buf, gif_std_gml_io__Buffer_BufferImpl_readBuffer(self.i, _buf, 0, arg0), buffer_u8, 0);
        buffer_seek(_buf, buffer_seek_start, 0);
        return buffer_read(_buf, buffer_string);
    };
    
    static read = function(arg0)
    {
        var _b = 71;
        
        if (buffer_read(self.i, buffer_u8) != _b)
            show_error("Invalid header", true);
        
        _b = 73;
        
        if (buffer_read(self.i, buffer_u8) != _b)
            show_error("Invalid header", true);
        
        _b = 70;
        
        if (buffer_read(self.i, buffer_u8) != _b)
            show_error("Invalid header", true);
        
        var _gifVer = self.read_string(3);
        var _version = global.format_gif_version_gif89a;
        
        switch (_gifVer)
        {
            case "87a":
                _version = global.format_gif_version_gif87a;
                break;
            
            case "89a":
                _version = global.format_gif_version_gif89a;
                break;
            
            default:
                _version = format_gif_version_unknown(_gifVer);
        }
        
        var _width = buffer_read(self.i, buffer_u16);
        var _height = buffer_read(self.i, buffer_u16);
        var _packedField = buffer_read(self.i, buffer_u8);
        var _bgIndex = buffer_read(self.i, buffer_u8);
        var _pixelAspectRatio = buffer_read(self.i, buffer_u8);
        
        if (_pixelAspectRatio != 0)
            _pixelAspectRatio = (_pixelAspectRatio + 15) / 64;
        else
            _pixelAspectRatio = 1;
        
        var _lsd = 
        {
            width: _width,
            height: _height,
            hasGlobalColorTable: (_packedField & 128) == 128,
            colorResolution: (_packedField & 112 & 4294967295) >> 4,
            sorted: (_packedField & 8) == 8,
            globalColorTableSize: 2 << (_packedField & 7),
            backgroundColorIndex: _bgIndex,
            pixelAspectRatio: _pixelAspectRatio
        };
        var _gct = undefined;
        
        if (_lsd.hasGlobalColorTable)
            _gct = self.read_color_table(_lsd.globalColorTableSize);
        
        var _blocks = [];
        
        if (arg0)
        {
            while (true)
            {
                _b = self.read_block();
                array_push(_blocks, _b);
                
                if (_b == global.format_gif_block_beof)
                    break;
            }
        }
        
        return 
        {
            version: _version,
            logicalScreenDescriptor: _lsd,
            globalColorTable: _gct,
            blocks: _blocks
        };
    };
    
    static read_next = function(arg0)
    {
        var _b = self.read_block();
        array_push(arg0, _b);
        return _b;
    };
    
    static read_block = function()
    {
        var _blockID = buffer_read(self.i, buffer_u8);
        
        switch (_blockID)
        {
            case 44:
                return self.read_image();
            
            case 33:
                return self.read_extension();
            
            case 59:
                return global.format_gif_block_beof;
        }
        
        return global.format_gif_block_beof;
    };
    
    static read_image = function()
    {
        var _x = buffer_read(self.i, buffer_u16);
        var _y = buffer_read(self.i, buffer_u16);
        var _width = buffer_read(self.i, buffer_u16);
        var _height = buffer_read(self.i, buffer_u16);
        var _packed = buffer_read(self.i, buffer_u8);
        var _localColorTable = (_packed & 128) == 128;
        var _interlaced = (_packed & 64) == 64;
        var _sorted = (_packed & 32) == 32;
        var _localColorTableSize = 2 << (_packed & 7);
        var _lct = undefined;
        
        if (_localColorTable)
            _lct = self.read_color_table(_localColorTableSize);
        
        var _frame = 
        {
            x: _x,
            y: _y,
            width: _width,
            height: _height,
            localColorTable: _localColorTable,
            interlaced: _interlaced,
            sorted: _sorted,
            localColorTableSize: _localColorTableSize,
            pixels: self.read_pixels(_width, _height, _interlaced),
            colorTable: _lct
        };
        return format_gif_block_bframe(_frame);
    };
    
    static read_pixels = function(arg0, arg1, arg2)
    {
        var _input = self.i;
        var _pixelsCount = arg0 * arg1;
        var _pixels = new gif_std_haxe_io_Bytes(array_create(_pixelsCount, 0));
        var _minCodeSize = buffer_read(_input, buffer_u8);
        var _blockSize = buffer_read(_input, buffer_u8) - 1;
        var _bits = buffer_read(_input, buffer_u8);
        var _bitsCount = 8;
        var _clearCode = 1 << _minCodeSize;
        var _eoiCode = _clearCode + 1;
        var _codeSize = _minCodeSize + 1;
        var _codeSizeLimit = 1 << _codeSize;
        var _codeMask = _codeSizeLimit - 1;
        var _baseDict = [];
        
        for (_i = 0; _i < _clearCode; _i++)
            _baseDict[_i] = [_i];
        
        var _dict = [];
        var _dictLen = _clearCode + 2;
        var _i = 0;
        var _code = 0;
        
        while (_i < _pixelsCount)
        {
            var _last = _code;
            
            while (_bitsCount < _codeSize)
            {
                if (_blockSize == 0)
                    break;
                
                _bits |= (buffer_read(_input, buffer_u8) << _bitsCount);
                _bitsCount += 8;
                _blockSize--;
                
                if (_blockSize == 0)
                    _blockSize = buffer_read(_input, buffer_u8);
            }
            
            _code = _bits & _codeMask;
            _bits = _bits >> _codeSize;
            _bitsCount -= _codeSize;
            
            if (_code == _clearCode)
            {
                _dict = gif_std_gml_internal_ArrayImpl_copy(_baseDict);
                _dictLen = _clearCode + 2;
                _codeSize = _minCodeSize + 1;
                _codeSizeLimit = 1 << _codeSize;
                _codeMask = _codeSizeLimit - 1;
                continue;
            }
            
            if (_code == _eoiCode)
                break;
            
            if (_code < _dictLen)
            {
                if (_last != _clearCode)
                {
                    _newRecord = gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
                    array_push(_newRecord, _dict[_code][0]);
                    _dict[_dictLen++] = _newRecord;
                }
            }
            else
            {
                if (_code != _dictLen)
                    show_error("Invalid LZW code. Excepted: " + string(_dictLen) + ", got: " + string(_code), true);
                
                _newRecord = gif_std_gml_internal_ArrayImpl_copy(_dict[_last]);
                array_push(_newRecord, _newRecord[0]);
                _dict[_dictLen++] = _newRecord;
            }
            
            var _newRecord = _dict[_code];
            var __g = 0;
            
            while (__g < array_length(_newRecord))
            {
                var _item = _newRecord[__g];
                __g++;
                _pixels.b[_i++] = _item & 255;
            }
            
            if (_dictLen == _codeSizeLimit && _codeSize < 12)
            {
                _codeSize++;
                _codeSizeLimit = 1 << _codeSize;
                _codeMask = _codeSizeLimit - 1;
            }
        }
        
        while (_blockSize > 0)
        {
            buffer_read(_input, buffer_u8);
            _blockSize--;
            
            if (_blockSize == 0)
                _blockSize = buffer_read(_input, buffer_u8);
        }
        
        while (_i < _pixelsCount)
            _pixels.b[_i++] = 0;
        
        if (arg2)
        {
            var _buffer1 = new gif_std_haxe_io_Bytes(array_create(_pixelsCount, 0));
            var _offset = self.deinterlace(_pixels, _buffer1, 8, 0, 0, arg0, arg1);
            _offset = self.deinterlace(_pixels, _buffer1, 8, 4, _offset, arg0, arg1);
            _offset = self.deinterlace(_pixels, _buffer1, 4, 2, _offset, arg0, arg1);
            _offset = self.deinterlace(_pixels, _buffer1, 2, 1, _offset, arg0, arg1);
            _pixels = _buffer1;
        }
        
        return _pixels;
    };
    
    static deinterlace = function(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    {
        while (arg3 < arg6)
        {
            array_copy(arg1.b, arg3 * arg5, arg0.b, arg4, arg5);
            arg4 += arg5;
            arg3 += arg2;
        }
        
        return arg4;
    };
    
    static read_extension = function()
    {
        var _subId = buffer_read(self.i, buffer_u8);
        
        switch (_subId)
        {
            case 249:
                if (buffer_read(self.i, buffer_u8) != 4)
                    show_error("Incorrect Graphic Control Extension block size!", true);
                
                var _packed = buffer_read(self.i, buffer_u8);
                var _disposalMethod;
                
                switch ((_packed & 28) >> 2)
                {
                    case 2:
                        _disposalMethod = global.format_gif_disposal_method_fill_background;
                        break;
                    
                    case 3:
                        _disposalMethod = global.format_gif_disposal_method_render_previous;
                        break;
                    
                    case 1:
                        _disposalMethod = global.format_gif_disposal_method_no_action;
                        break;
                    
                    case 0:
                        _disposalMethod = global.format_gif_disposal_method_unspecified;
                        break;
                    
                    default:
                        _disposalMethod = format_gif_disposal_method_undefined_hx((_packed & 28) >> 2);
                }
                
                var _delay = buffer_read(self.i, buffer_u16);
                var _gcx = 
                {
                    disposalMethod: _disposalMethod,
                    userInput: (_packed & 2) == 2,
                    hasTransparentColor: (_packed & 1) == 1,
                    delay: _delay,
                    transparentIndex: buffer_read(self.i, buffer_u8)
                };
                var _b = format_gif_block_bextension(format_gif_extension_egraphic_control(_gcx));
                buffer_read(self.i, buffer_u8);
                return _b;
            
            case 1:
                if (buffer_read(self.i, buffer_u8) != 12)
                    show_error("Incorrect size of Plain Text Extension introducer block.", true);
                
                var _textGridX = buffer_read(self.i, buffer_u16);
                var _textGridY = buffer_read(self.i, buffer_u16);
                var _textGridWidth = buffer_read(self.i, buffer_u16);
                var _textGridHeight = buffer_read(self.i, buffer_u16);
                var _charCellWidth = buffer_read(self.i, buffer_u8);
                var _charCellHeight = buffer_read(self.i, buffer_u8);
                var _textForegroundColorIndex = buffer_read(self.i, buffer_u8);
                var _textBackgroundColorIndex = buffer_read(self.i, buffer_u8);
                var _buffer1 = new gif_std_haxe_io_BytesOutput();
                var _bytes = new gif_std_haxe_io_Bytes(array_create(255, 0));
                var _bdata = _bytes.b;
                var _len = buffer_read(self.i, buffer_u8);
                
                while (_len != 0)
                {
                    for (var _k = 0; _k < _len; _k++)
                        _bdata[_k] = buffer_read(self.i, buffer_u8);
                    
                    _buffer1.writeBytes(_bytes, 0, _len);
                    _len = buffer_read(self.i, buffer_u8);
                }
                
                _buffer1.flush();
                _bytes = new gif_std_haxe_io_Bytes(_buffer1.data);
                _buffer1.close();
                var __this = _bytes;
                var _ptx = 
                {
                    textGridX: _textGridX,
                    textGridY: _textGridY,
                    textGridWidth: _textGridWidth,
                    textGridHeight: _textGridHeight,
                    charCellWidth: _charCellWidth,
                    charCellHeight: _charCellHeight,
                    textForegroundColorIndex: _textForegroundColorIndex,
                    textBackgroundColorIndex: _textBackgroundColorIndex,
                    text: haxe_io__bytes_bytes_impl_get_string(__this.b, 0, array_length(__this.b))
                };
                return format_gif_block_bextension(format_gif_extension_etext(_ptx));
            
            case 254:
                _buffer1 = new gif_std_haxe_io_BytesOutput();
                _bytes = new gif_std_haxe_io_Bytes(array_create(255, 0));
                _bdata = _bytes.b;
                _len = buffer_read(self.i, buffer_u8);
                
                while (_len != 0)
                {
                    for (var _k = 0; _k < _len; _k++)
                        _bdata[_k] = buffer_read(self.i, buffer_u8);
                    
                    _buffer1.writeBytes(_bytes, 0, _len);
                    _len = buffer_read(self.i, buffer_u8);
                }
                
                _buffer1.flush();
                _bytes = new gif_std_haxe_io_Bytes(_buffer1.data);
                _buffer1.close();
                __this = _bytes;
                return format_gif_block_bextension(format_gif_extension_ecomment(haxe_io__bytes_bytes_impl_get_string(__this.b, 0, array_length(__this.b))));
            
            case 255:
                return self.read_application_extension();
            
            default:
                _buffer1 = new gif_std_haxe_io_BytesOutput();
                _bytes = new gif_std_haxe_io_Bytes(array_create(255, 0));
                _bdata = _bytes.b;
                _len = buffer_read(self.i, buffer_u8);
                
                while (_len != 0)
                {
                    for (var _k = 0; _k < _len; _k++)
                        _bdata[_k] = buffer_read(self.i, buffer_u8);
                    
                    _buffer1.writeBytes(_bytes, 0, _len);
                    _len = buffer_read(self.i, buffer_u8);
                }
                
                _buffer1.flush();
                _bytes = new gif_std_haxe_io_Bytes(_buffer1.data);
                _buffer1.close();
                return format_gif_block_bextension(format_gif_extension_eunknown(_subId, _bytes));
        }
    };
    
    static read_application_extension = function()
    {
        if (buffer_read(self.i, buffer_u8) != 11)
            show_error("Incorrect size of Application Extension introducer block.", true);
        
        var _name = self.read_string(8);
        var _version = self.read_string(3);
        var _buffer1 = new gif_std_haxe_io_BytesOutput();
        var _bytes = new gif_std_haxe_io_Bytes(array_create(255, 0));
        var _bdata = _bytes.b;
        var _len = buffer_read(self.i, buffer_u8);
        
        while (_len != 0)
        {
            for (var _k = 0; _k < _len; _k++)
                _bdata[_k] = buffer_read(self.i, buffer_u8);
            
            _buffer1.writeBytes(_bytes, 0, _len);
            _len = buffer_read(self.i, buffer_u8);
        }
        
        _buffer1.flush();
        _bytes = new gif_std_haxe_io_Bytes(_buffer1.data);
        _buffer1.close();
        var _data = _bytes;
        
        if (_name == "NETSCAPE" && _version == "2.0" && _data.b[0] == 1)
            return format_gif_block_bextension(format_gif_extension_eapplication_extension(format_gif_application_extension_aenetscape_looping(_data.b[1] | (_data.b[2] << 8))));
        
        return format_gif_block_bextension(format_gif_extension_eapplication_extension(format_gif_application_extension_aeunknown(_name, _version, _data)));
    };
    
    static read_color_table = function(arg0)
    {
        arg0 *= 3;
        var _output = new gif_std_haxe_io_Bytes(array_create(arg0, 0));
        
        for (var _c = 0; _c < arg0; _c += 3)
        {
            var _v = buffer_read(self.i, buffer_u8);
            _output.b[_c] = _v & 255;
            var _v1 = buffer_read(self.i, buffer_u8);
            _output.b[_c + 1] = _v1 & 255;
            var _v2 = buffer_read(self.i, buffer_u8);
            _output.b[_c + 2] = _v2 & 255;
        }
        
        return _output;
    };
    
    static __class__ = global.mt_gif_raw_reader;
    
    self.i = arg0;
}

function gif_std_Std_stringify(arg0)
{
    if (arg0 == undefined)
        return "null";
    
    if (is_string(arg0))
        return arg0;
    
    if (is_struct(arg0))
    {
        var _e = struct_get_from_hash(arg0, variable_get_hash("__enum__"));
        
        if (_e == undefined)
            return string(arg0);
        
        var _ects = _e.constructors;
        var _s;
        
        if (_ects != undefined)
        {
            _i = arg0.__enumIndex__;
            
            if (_i >= 0 && _i < array_length(_ects))
                _s = _ects[_i];
            else
                _s = "?";
        }
        else
        {
            _s = instanceof(arg0);
            
            if (string_copy(_s, 1, 3) == "mc_")
                _s = string_delete(_s, 1, 3);
            
            _n = string_length(_e.name);
            
            if (string_copy(_s, 1, _n) == _e.name)
                _s = string_delete(_s, 1, _n + 1);
        }
        
        _s += "(";
        var _fields = arg0.__enumParams__;
        var _n = array_length(_fields);
        var _i = -1;
        
        while (++_i < _n)
        {
            if (_i > 0)
                _s += ", ";
            
            _s += gif_std_Std_stringify(variable_struct_get(arg0, array_get(_fields, _i)));
        }
        
        return _s + ")";
    }
    
    if (is_real(arg0))
    {
        var _s = string_format(arg0, 0, 16);
        var _n = string_byte_length(_s);
        var _i = _n;
        
        while (_i > 0)
        {
            switch (string_byte_at(_s, _i))
            {
                case 48:
                    _i--;
                    continue;
                
                case 46:
                    _i--;
                    break;
            }
            
            break;
        }
        
        return string_copy(_s, 1, _i);
    }
    
    return string(arg0);
}

function mc_format_gif_block() constructor
{
    static getIndex = method(undefined, gif_std_enum_getIndex);
    static toString = method(undefined, gif_std_enum_toString);
    static __enum__ = global.mt_format_gif_block;
}

function mc_format_gif_block_bframe() : mc_format_gif_block() constructor
{
    static __enumParams__ = ["frame"];
    static __enumIndex__ = 0;
}

function format_gif_block_bframe(arg0)
{
    var _this = new mc_format_gif_block_bframe();
    _this.frame = arg0;
    return _this;
}

function mc_format_gif_block_bextension() : mc_format_gif_block() constructor
{
    static __enumParams__ = ["extension"];
    static __enumIndex__ = 1;
}

function format_gif_block_bextension(arg0)
{
    var _this = new mc_format_gif_block_bextension();
    _this.extension = arg0;
    return _this;
}

function mc_format_gif_block_beof() : mc_format_gif_block() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 2;
}

global.format_gif_block_beof = new mc_format_gif_block_beof();

function mc_format_gif_extension() constructor
{
    static getIndex = method(undefined, gif_std_enum_getIndex);
    static toString = method(undefined, gif_std_enum_toString);
    static __enum__ = global.mt_format_gif_extension;
}

function mc_format_gif_extension_egraphic_control() : mc_format_gif_extension() constructor
{
    static __enumParams__ = ["gce"];
    static __enumIndex__ = 0;
}

function format_gif_extension_egraphic_control(arg0)
{
    var _this = new mc_format_gif_extension_egraphic_control();
    _this.gce = arg0;
    return _this;
}

function mc_format_gif_extension_ecomment() : mc_format_gif_extension() constructor
{
    static __enumParams__ = ["text"];
    static __enumIndex__ = 1;
}

function format_gif_extension_ecomment(arg0)
{
    var _this = new mc_format_gif_extension_ecomment();
    _this.text = arg0;
    return _this;
}

function mc_format_gif_extension_etext() : mc_format_gif_extension() constructor
{
    static __enumParams__ = ["pte"];
    static __enumIndex__ = 2;
}

function format_gif_extension_etext(arg0)
{
    var _this = new mc_format_gif_extension_etext();
    _this.pte = arg0;
    return _this;
}

function mc_format_gif_extension_eapplication_extension() : mc_format_gif_extension() constructor
{
    static __enumParams__ = ["ext"];
    static __enumIndex__ = 3;
}

function format_gif_extension_eapplication_extension(arg0)
{
    var _this = new mc_format_gif_extension_eapplication_extension();
    _this.ext = arg0;
    return _this;
}

function mc_format_gif_extension_eunknown() : mc_format_gif_extension() constructor
{
    static __enumParams__ = ["id", "data"];
    static __enumIndex__ = 4;
}

function format_gif_extension_eunknown(arg0, arg1)
{
    var _this = new mc_format_gif_extension_eunknown();
    _this.id = arg0;
    _this.data = arg1;
    return _this;
}

function mc_format_gif_application_extension() constructor
{
    static getIndex = method(undefined, gif_std_enum_getIndex);
    static toString = method(undefined, gif_std_enum_toString);
    static __enum__ = global.mt_format_gif_application_extension;
}

function mc_format_gif_application_extension_aenetscape_looping() : mc_format_gif_application_extension() constructor
{
    static __enumParams__ = ["loops"];
    static __enumIndex__ = 0;
}

function format_gif_application_extension_aenetscape_looping(arg0)
{
    var _this = new mc_format_gif_application_extension_aenetscape_looping();
    _this.loops = arg0;
    return _this;
}

function mc_format_gif_application_extension_aeunknown() : mc_format_gif_application_extension() constructor
{
    static __enumParams__ = ["name", "version", "data"];
    static __enumIndex__ = 1;
}

function format_gif_application_extension_aeunknown(arg0, arg1, arg2)
{
    var _this = new mc_format_gif_application_extension_aeunknown();
    _this.name = arg0;
    _this.version = arg1;
    _this.data = arg2;
    return _this;
}

function mc_format_gif_version() constructor
{
    static getIndex = method(undefined, gif_std_enum_getIndex);
    static toString = method(undefined, gif_std_enum_toString);
    static __enum__ = global.mt_format_gif_version;
}

function mc_format_gif_version_gif87a() : mc_format_gif_version() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 0;
}

global.format_gif_version_gif87a = new mc_format_gif_version_gif87a();

function mc_format_gif_version_gif89a() : mc_format_gif_version() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 1;
}

global.format_gif_version_gif89a = new mc_format_gif_version_gif89a();

function mc_format_gif_version_unknown() : mc_format_gif_version() constructor
{
    static __enumParams__ = ["version"];
    static __enumIndex__ = 2;
}

function format_gif_version_unknown(arg0)
{
    var _this = new mc_format_gif_version_unknown();
    _this.version = arg0;
    return _this;
}

function mc_format_gif_disposal_method() constructor
{
    static getIndex = method(undefined, gif_std_enum_getIndex);
    static toString = method(undefined, gif_std_enum_toString);
    static __enum__ = global.mt_format_gif_disposal_method;
}

function mc_format_gif_disposal_method_unspecified() : mc_format_gif_disposal_method() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 0;
}

global.format_gif_disposal_method_unspecified = new mc_format_gif_disposal_method_unspecified();

function mc_format_gif_disposal_method_no_action() : mc_format_gif_disposal_method() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 1;
}

global.format_gif_disposal_method_no_action = new mc_format_gif_disposal_method_no_action();

function mc_format_gif_disposal_method_fill_background() : mc_format_gif_disposal_method() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 2;
}

global.format_gif_disposal_method_fill_background = new mc_format_gif_disposal_method_fill_background();

function mc_format_gif_disposal_method_render_previous() : mc_format_gif_disposal_method() constructor
{
    static __enumParams__ = [];
    static __enumIndex__ = 3;
}

global.format_gif_disposal_method_render_previous = new mc_format_gif_disposal_method_render_previous();

function mc_format_gif_disposal_method_undefined_hx() : mc_format_gif_disposal_method() constructor
{
    static __enumParams__ = ["index"];
    static __enumIndex__ = 4;
}

function format_gif_disposal_method_undefined_hx(arg0)
{
    var _this = new mc_format_gif_disposal_method_undefined_hx();
    _this.index = arg0;
    return _this;
}

function gif_std_haxe_class(arg0, arg1) constructor
{
    static superClass = undefined;
    static marker = undefined;
    static index = undefined;
    static name = undefined;
    static __class__ = "class";
    
    self.superClass = undefined;
    self.marker = global.gif_std_haxe_type_markerValue;
    self.index = arg0;
    self.name = arg1;
}

function gif_std_haxe_enum(arg0, arg1, arg2, arg3) constructor
{
    static constructors = undefined;
    static functions = undefined;
    static marker = undefined;
    static index = undefined;
    static name = undefined;
    static __class__ = "enum";
    
    self.marker = global.gif_std_haxe_type_markerValue;
    self.index = arg0;
    self.name = arg1;
    self.constructors = arg2;
    self.functions = arg3;
}

function gif_std_gml_NativeTypeHelper_isNumber(arg0)
{
    return (is_real(arg0) || is_bool(arg0) || is_int32(arg0)) || is_int64(arg0);
}

function gif_std_gml_internal_ArrayImpl_copy(arg0)
{
    var _len = array_length(arg0);
    var _out;
    
    if (_len > 0)
    {
        _out = array_create(_len, 0);
        array_copy(_out, 0, arg0, 0, _len);
    }
    else
    {
        _out = [];
    }
    
    return _out;
}

function gif_std_gml_io__Buffer_BufferImpl_readBuffer(arg0, arg1, arg2, arg3)
{
    var _srcPos = buffer_tell(arg0);
    var _srcLen = min(arg3, buffer_get_size(arg0) - _srcPos);
    var _dstLen = min(_srcLen, buffer_get_size(arg1) - arg2);
    
    if (_srcLen < 0)
        return 0;
    
    if (_dstLen < 0)
    {
        buffer_seek(arg0, buffer_seek_relative, _srcLen);
        return 0;
    }
    
    buffer_copy(arg0, _srcPos, _dstLen, arg1, arg2);
    buffer_seek(arg0, buffer_seek_relative, _srcLen);
    return _dstLen;
}

function gif_std_haxe_io_Bytes(arg0) constructor
{
    static b = undefined;
    static __class__ = global.mt_gif_std_haxe_io_Bytes;
    
    self.b = arg0;
}

function haxe_io__bytes_bytes_impl_get_string(arg0, arg1, arg2)
{
    var _b = global.haxe_io__bytes_bytes_impl_buffer;
    buffer_seek(_b, buffer_seek_start, 0);
    
    while (--arg2 >= 0)
        buffer_write(_b, buffer_u8, arg0[arg1++]);
    
    buffer_write(_b, buffer_u8, 0);
    buffer_seek(_b, buffer_seek_start, 0);
    return buffer_read(_b, buffer_string);
}

function gif_std_haxe_io_Output_new()
{
    self.dataLen = 32;
    self.dataPos = 0;
    self.data = array_create(32, 0);
}

function gif_std_haxe_io_Output() constructor
{
    static data = undefined;
    static dataPos = undefined;
    static dataLen = undefined;
    static flush = method(undefined, gif_std_haxe_io_Output_flush);
    static close = method(undefined, gif_std_haxe_io_Output_close);
    static writeBytes = method(undefined, gif_std_haxe_io_Output_writeBytes);
    static __class__ = global.mt_gif_std_haxe_io_Output;
    
    method(self, gif_std_haxe_io_Output_new)();
}

function gif_std_haxe_io_Output_flush()
{
}

function gif_std_haxe_io_Output_close()
{
}

function gif_std_haxe_io_Output_writeBytes(arg0, arg1, arg2)
{
    var _bd = arg0.b;
    var _p0 = self.dataPos;
    var _p1 = _p0 + arg2;
    var _d = self.data;
    var _dlen = self.dataLen;
    
    if (_p1 > _dlen)
    {
        do
            _dlen *= 2;
        until (_p1 <= _dlen);
        
        _dlen *= 2;
        _d[_dlen - 1] = 0;
        self.dataLen = _dlen;
    }
    
    array_copy(_d, _p0, _bd, arg1, arg2);
    self.dataPos = _p1;
    return arg2;
}

function gif_std_haxe_io_BytesOutput() constructor
{
    static data = undefined;
    static dataPos = undefined;
    static dataLen = undefined;
    static flush = method(undefined, gif_std_haxe_io_Output_flush);
    static close = method(undefined, gif_std_haxe_io_Output_close);
    static writeBytes = method(undefined, gif_std_haxe_io_Output_writeBytes);
    static __class__ = global.mt_gif_std_haxe_io_BytesOutput;
    
    method(self, gif_std_haxe_io_Output_new)();
}

global.gif_drawer_white32 = -1;
global.gif_raw_reader_read_string_tmp_buf = -1;
global.haxe_io__bytes_bytes_impl_buffer = buffer_create(128, buffer_grow, 1);
