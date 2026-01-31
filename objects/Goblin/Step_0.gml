if (move_timer > 0) 
{
    move_timer--;
} 
else 
{
    current_dir = irandom(7); 
    var _chosen_dir = _directions[current_dir];
    
    var quantity = 0;
    for (var i = 0; i < array_length(_last_movements); i++) {
        if (_last_movements[i] == _chosen_dir) {
            quantity++;
        }
    }

    if (quantity >= 2) {
        current_dir = (current_dir + 1) % 8; 
        _chosen_dir = _directions[current_dir];
    }
	
    array_push(_last_movements, _chosen_dir);
    
    if (array_length(_last_movements) > 4) {
        array_delete(_last_movements, 0, 1);
    }

    move_timer = 90;
    
    //show_debug_message("Nova direção: " + _chosen_dir + " | Repetições: " + string(quantity));
}

if (current_dir != -1) {
    var _dir_name = _directions[current_dir];
    var _vx = 0;
    var _vy = 0;

    if (_dir_name == "north")      { _vy = -move_speed; }
    else if (_dir_name == "south") { _vy = move_speed; }
    else if (_dir_name == "east")  { _vx = move_speed; }
    else if (_dir_name == "west")  { _vx = -move_speed; }
    else if (_dir_name == "northwest") { _vx = -move_speed * 0.7; _vy = -move_speed * 0.7; }
    else if (_dir_name == "northest")  { _vx = move_speed * 0.7;  _vy = -move_speed * 0.7; }
    else if (_dir_name == "southeast") { _vx = move_speed * 0.7;  _vy = move_speed * 0.7; }
    else if (_dir_name == "southwest") { _vx = -move_speed * 0.7; _vy = move_speed * 0.7; }

    // Aplica o movimento com colisão
    move_and_collide(_vx, _vy, obj_wall);
}