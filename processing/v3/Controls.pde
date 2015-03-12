/* Notes:
 *
 */


// handle serial controls
void handle_controls() {
  PVector in = PVector.sub(EULER, INIT_EULER);
  
  iterate_layers(in.z / 100);
  
  if (BTN_R) {  // trigger a jump
    trigger_jump();
  }
  if (BTN_L) {
    JUMPING = false;
  } else
    JUMPING = true;
}


// trigger a jump to begin
void trigger_jump() {
  if (!JUMPING) {
    V_Y = 50;
    
    JUMPING = true;
  }
}


