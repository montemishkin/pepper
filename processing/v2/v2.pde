/* Notes:
 *
 */


import processing.serial.*;


// using serial port data?
boolean USING_SERIAL = true;

// serial port to read from
Serial PORT;
// time of most recent serial event
float LAST_SERIAL_TIME = 0;
// if there has been a serial event since last update of global variables
boolean SERIAL_READY = false;
// the initial euler angles to compare to
PVector INIT_EULER = new PVector();
// euler angles to read from serial port
PVector EULER = new PVector();
// light reading from photo sensor
FloatBuffer LIGHT = new FloatBuffer(100);
// buffer logging sound readings from microphone
FloatBuffer SOUND = new FloatBuffer(300);
// left button reading
boolean BTN_L = false;
// right button reading
boolean BTN_R = false;

// position of the eye (in pixels)
PVector CAMERA_EYE;
// position of the scene center (in pixels)
PVector CAMERA_CENTER;
// direction of "down"
PVector CAMERA_AXIS;

// ambient light color
color AMB_LIGHT = color(0);
// spot light color
color SPOT_LIGHT = color(255);
// spot light cone angle
float SPOT_LIGHT_ANGLE = PI / 4;
// spot light concentration
float SPOT_LIGHT_CONCENTRATION = 1;

// the horizontal positions (in pixels) of the layers
float[] LAYER_POSITIONS = new float[3];
// the horizontal speeds (in pixels) of the layers
float[] LAYER_SPEEDS = {1, 7, 13};

// is the character executing a jump?
boolean JUMPING = false;
// y position of the floor (in pixels)
float FLOOR_Y = 100;
// y position of character (in pixels)
float R_Y = FLOOR_Y;
// y velocity of character (in pixels)
float V_Y = 0;

// number of stars
int NUM_STARS = 100;
// positions of the stars (in pixels)
PVector[] STAR_POSITIONS = new PVector[100];

// global time step
float DT = 0.3;


void setup() {
  // size the window to full screen, P3D renderer is just faster
  size(displayWidth, displayHeight, P3D);
  
  if (USING_SERIAL) {
    // open serial port at 115200 baud
    PORT = new Serial(this, "/dev/tty.usbmodem1421", 115200);
    // only trigger serial events when newline is recieved
    PORT.bufferUntil('\n');
    // send character to arduino to indicate ready
    PORT.write('r');
  } else {
    // set light buffer to HIGH so that you can see
    LIGHT.set_all(1023);
  }
  
  CAMERA_EYE = new PVector(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0));
  CAMERA_CENTER = new PVector(width/2.0, height/2.0, 0);
  CAMERA_AXIS = new PVector(0, 1, 0);
  
  for (int i = 0; i < NUM_STARS; i++)
    STAR_POSITIONS[i] = new PVector(random(width), random(height - FLOOR_Y));
}


void draw() {
  // if using serial controls and it has been over a second since last serial event
  if (USING_SERIAL & (millis() - LAST_SERIAL_TIME > 1000)) {
    // resend command to initialize
    PORT.write('r');
    // set last event time to now
    LAST_SERIAL_TIME = millis();
    // log status
    println("Disconnected. Attempting to re-connect.  Time: " + str(LAST_SERIAL_TIME));
  }
  
  // interpret user input
  if (USING_SERIAL)
    handle_controls();
  handle_keys();
  
  // update global vars based on serial data
  if (SERIAL_READY)
    update_globals();
  
  // iterate content
  if (JUMPING)
    iterate_jump();

  // clear background
  background(0);
  
//  // set up the lighting
//  PVector look = PVector.sub(CAMERA_CENTER, CAMERA_EYE).normalize(null);
//  spotLight(red(SPOT_LIGHT), green(SPOT_LIGHT), blue(SPOT_LIGHT), // color 
//            CAMERA_EYE.x   , CAMERA_EYE.y     , CAMERA_EYE.z    , // position
//            look.x         , look.y           , look.z          , // direction
//            SPOT_LIGHT_ANGLE,                                     // cone angle
//            SPOT_LIGHT_CONCENTRATION);                            // concentration
//  ambientLight(AMB_LIGHT >> 16 & 0xFF,
//               AMB_LIGHT >>  8 & 0xFF,
//               AMB_LIGHT >>      0xFF); 
  
  // render content
  render_bg_layers();
  render_character();
  render_fg_layers();
}


//------------------------------------------------------------------------
//------------------------------------------------------------------------


void serialEvent(Serial port) {
  LAST_SERIAL_TIME = millis();

  String in_string = port.readString();
  String[] in_array = split(in_string, ',');
  
  in_array = trim(in_array);
  
  if (in_array.length != 7)
    println("Unrecognized Serial Data: " + in_string);
  else {
    // if first serial event ever then record initial angles
    if (LAST_SERIAL_TIME == 0) {
      INIT_EULER.x = float(in_array[0]);
      INIT_EULER.y = float(in_array[1]);
      INIT_EULER.z = float(in_array[2]);
    }
    
    // set flag to update global vars based on serial data
    SERIAL_READY = true;
    
    // angle about MPU z axis
    EULER.x = float(in_array[0]);
    // angle about MPU y axis
    EULER.y = float(in_array[1]);
    // angle about MPU x axis
    EULER.z = float(in_array[2]);
    
    // light reading from photo sensor
    LIGHT.push(float(in_array[3]));
    
    // sound reading from microphone
    SOUND.push(float(in_array[4]));
    
    // left button reading
    BTN_L = boolean(int(in_array[5]));
    // right button reading
    BTN_R = boolean(int(in_array[6]));
  }
}


// update global variables based on serial data
void update_globals() {
  SERIAL_READY = false;
  
  //LIGHT.update();
  SOUND.update();
  
  float l = LIGHT.get_last();
  float s_n = SOUND.get_avg_over(SOUND.get_size() - 10, SOUND.get_size());
  float s_o = SOUND.get_avg_over(0, SOUND.get_size() - 10);
  float s = s_n - s_o;
  
  AMB_LIGHT = color(map(l, 0, 1023, 20, 0), 
                    map(l, 0, 1023, 0, 20), 
                    map(l, 0, 1023, 20, 0));
  SPOT_LIGHT_ANGLE = map(l, 0, 1023, PI / 8, PI / 4);
  SPOT_LIGHT_CONCENTRATION = map(l, 0, 1023, 40, 1);
}


