/* Notes:
 *
 */


// handle keyboard controls
void handle_keys() {
  if (UP_DOWN) {  // trigger a jump
    if (!JUMPING) {
      V_Y = 50;
      
      JUMPING = true;
    }
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


