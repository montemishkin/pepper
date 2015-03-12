/* Notes:
 *
 */


import processing.serial.*;


// stores info to log to loading screen
String CONSOLE = "CORE BOOT: Initializing Super Cool Monte System...\n";


// Serial Variables
//---------------------------------------------------------------------
// have we begun recieving valid serial data?
boolean SERIAL_BEGUN = false;
// serial port to read from
Serial PORT;
// time of most recent serial event
float LAST_SERIAL_TIME = 0;
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


// Scene Variables
//---------------------------------------------------------------------
// the horizontal positions (in pixels) of the layers
float[] LAYER_POSITIONS = new float[6];
// the horizontal speeds (in pixels) of the layers
float[] LAYER_SPEEDS = {1, 7, 8, 9, 10, 13};
// number of stars
int N_STARS = 100;
// positions of the stars (in pixels)
PVector[] STARS = new PVector[100];
// simple finch image
PImage FINCH;
// flying finch image
PImage FLY_FINCH;
// dragon image
PImage DRAGON;
// zombie image
PImage ZOMBIE;


// Simulation Variables
//---------------------------------------------------------------------
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


