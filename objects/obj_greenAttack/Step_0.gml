life -= delta_time / 500000;

if (life <= 0) {
    instance_destroy();
}