/* Notes:
 *
 */


// iterates the character's jump.  Only call when JUMPING is true!
void iterate_jump() {
  R_Y += V_Y * DT;
  V_Y -= 10 * DT; 
  
  if (R_Y < FLOOR_Y) {
    R_Y = FLOOR_Y;
    V_Y = 0;
    JUMPING = false;
  }
}


// iterate all layer positions
void iterate_layers(float dx) {
  for (int i = 0; i < LAYER_POSITIONS.length; i++)
    LAYER_POSITIONS[i] += dx * LAYER_SPEEDS[i];
}

