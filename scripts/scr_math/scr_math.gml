function approach(_value, _target, _speed)
{
    if (_value < _target)
        return min(_value + _speed, _target);
    else
        return max(_value - _speed, _target);
}

function getTime(_minutes = 1, _seconds = 30)
{
    return (_minutes * 60 * 60) + (_seconds * 60);
}

function wrap(_value, __min, __max)
{
    var value = floor(_value);
    var _min = floor(min(__min, __max));
    var _max = floor(max(__min, __max));
    var range = (_max - _min) + 1;
    return ((((value - _min) % range) + range) % range) + _min;
}

function wave(_base, _range, _time, _offset)
{
    var a4 = (_range - _base) * 0.5;
    return _base + a4 + (sin((((current_time * 0.001) + (_time * _offset)) / _time) * (2 * pi)) * a4);
}

function chance(_real)
{
    return _real > random(1);
}
