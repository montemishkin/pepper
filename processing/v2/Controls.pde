/* Notes:
 *
 */


// handle serial controls
void handle_controls() {
  PVector in = PVector.mult(PVector.sub(EULER, INIT_EULER), -1);
  // positive in.y means front tilted up?
  // positive in.z means left tilted down?
  
  iterate_layers(-in.z / 100);
  
  if (BTN_R) {  // trigger a jump
    trigger_jump();
  }
  if (BTN_L) {
  }
}


// handle keyboard controls
void handle_keys() {
  if (UP_DOWN) {  // trigger a jump
    trigger_jump();
  }
  if (DOWN_DOWN) {
  }
  if (LEFT_DOWN) {
    iterate_layers(1);
  }
  if (RIGHT_DOWN) {
    iterate_layers(-1);
  }
}


// trigger a jump to begin
void trigger_jump() {
  if (!JUMPING) {
    V_Y = 50;
    
    JUMPING = true;
  }
}


//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------


// keyboard state variables
boolean UP_DOWN = false;
boolean DOWN_DOWN = false;
boolean LEFT_DOWN = false;
boolean RIGHT_DOWN = false;


// update keyboard state
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)
      UP_DOWN = true;
    else if (keyCode == DOWN)
      DOWN_DOWN = true;
    else if (keyCode == LEFT)
      LEFT_DOWN = true;
    else if (keyCode == RIGHT)
      RIGHT_DOWN = true;
  }
}


// update keyboard state
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)
      UP_DOWN = false;
    else if (keyCode == DOWN)
      DOWN_DOWN = false;
    else if (keyCode == LEFT)
      LEFT_DOWN = false;
    else if (keyCode == RIGHT)
      RIGHT_DOWN = false;
  }
}


