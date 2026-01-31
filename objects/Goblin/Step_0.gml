// --- LÓGICA DE DECISÃO (Timer) ---
if (move_timer > 0) 
{
    move_timer--;
} 
else 
{
    // 1. Escolhe uma direção aleatória inicial
    current_dir = irandom(7); 
    var _chosen_dir = _directions[current_dir];
    
    // 2. Verifica quantas vezes essa direção aparece no histórico recente
    var quantity = 0;
    for (var i = 0; i < array_length(_last_movements); i++) {
        if (_last_movements[i] == _chosen_dir) {
            quantity++;
        }
    }

    // 3. Se já repetiu muito (2 vezes ou mais), pula para a próxima direção da lista
    if (quantity >= 2) {
        current_dir = (current_dir + 1) % 8; // O %8 garante que o 8 vire 0 (loop do array)
        _chosen_dir = _directions[current_dir];
    }

    // 4. Salva a nova direção no histórico
    array_push(_last_movements, _chosen_dir);
    
    // Mantém o histórico com no máximo 4 itens
    if (array_length(_last_movements) > 4) {
        array_delete(_last_movements, 0, 1);
    }

    // 5. Reseta o timer (90 frames = 1.5 segundos em 60fps)
    move_timer = 90;
    
    show_debug_message("Nova direção: " + _chosen_dir + " | Repetições: " + string(quantity));
}

// --- LÓGICA DE MOVIMENTAÇÃO (Executa todo frame) ---
// Só move se tiver uma direção definida
if (current_dir != -1) {
    var _dir_name = _directions[current_dir];
    var _vx = 0;
    var _vy = 0;

    // Define os vetores de velocidade baseados na direção
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