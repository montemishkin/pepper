/* Notes:
 *   You gotta implement Serial now.
 *
 *   Make the background clouds move around based on input.
 *   Actually, maybe make all layers generated via input in some way.
 *   The noisy sound data can be grass.
 *
 */


// is the character executing a jump?
boolean JUMPING = false;
// y position of the floor (in pixels)
float FLOOR_Y = 100;
// y position of character (in pixels)
float R_Y = FLOOR_Y;
// y velocity of character (in pixels)
float V_Y = 0;

// global time step
float DT = 0.3;

// the horizontal positions (in pixels) of the layers
float[] LAYER_POSITIONS = new float[3];
// the horizontal speeds (in pixels) of the layers
float[] LAYER_SPEEDS = {5, 7, 9};


void setup() {
  // size the window to full screen, P3D renderer is just faster
  size(displayWidth, displayHeight, P3D);
}


void draw() {
  // interpret user input
  handle_keys();
  
  // iterate content
  if (JUMPING)
    iterate_jump();

  // render content
  background(0, 200, 200);
  render_layers();
  render_character();
}


