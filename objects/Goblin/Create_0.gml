randomize()

move_timer = 0;      // Contador de tempo
move_delay = 60;     // Quanto tempo ele espera (60 frames = 1 segundo)
current_dir = -1;    // -1 significa que ele está parado
move_speed = 1.5;      // Velocidade constante (melhor que passos aleatórios)

_directions = ["north", "south", "east", "west", "northwest", "northest", "southeast", "southwest", "idle"];
_last_movements =[];