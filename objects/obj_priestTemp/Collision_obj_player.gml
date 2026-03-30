if (other.state != states.ski)
    exit;

other.state = states.normal;
other.movespeed = 0;
other.sprite_index = spr_player_idle;
