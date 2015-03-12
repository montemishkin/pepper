/* Notes:
 *
 */


void setup() {
  // full screen the window and enable 3d graphics
  size(displayWidth, displayHeight, P3D);
  // hide the mouse
  noCursor();
  // any text that is drawn should be big
  textSize(20);

  // open serial port at 115200 baud
  PORT = new Serial(this, "/dev/tty.usbmodem1421", 115200);
  // only trigger serial events when newline is recieved
  PORT.bufferUntil('\n');
  // send character to arduino to indicate ready
  PORT.write('r');
  
  // load all images
  FINCH = loadImage("finch3d.png");
  FLY_FINCH = loadImage("fly_finch.png");
  DRAGON = loadImage("dragon.png");
  ZOMBIE = loadImage("god.png");
  
  // initialize star positions
  for (int i = 0; i < N_STARS; i++)
    STARS[i] = new PVector(random(width), random(height - FLOOR_Y));
}


void draw() {
  // if has been over a second since last serial event
  if (millis() - LAST_SERIAL_TIME > 1000) {
    // resend command to initialize mpu
    PORT.write('r');
    // set last event time to now
    LAST_SERIAL_TIME = millis();
    // log status
    CONSOLE += ">>> Disconnected. Attempting to re-connect.  Time: " 
                                      + str(LAST_SERIAL_TIME) + "\n";
  }
  
  // if haven't yet received valid data packet
  if (!SERIAL_BEGUN) {
    // log the console to the display
    render_console();
    // exit the draw loop early
    return;
  }
  
  // interpret user input
  handle_controls();
  
  // iterate content
  if (JUMPING)
    iterate_jump();

  // clear background
  background(0);
  
  // render content
  render_bg_layers();
  render_character();
  render_fg_layers();
}


void serialEvent(Serial port) {
  LAST_SERIAL_TIME = millis();

  String in_string = port.readString();
  String[] in_array = split(in_string, ',');
  
  in_array = trim(in_array);
  
  if (in_array.length != 7)
    CONSOLE += ">>> Non data-packet string received: " + in_string;
  else {
    // if first serial event ever then record initial angles
    if (!SERIAL_BEGUN) {
      INIT_EULER.x = float(in_array[0]);
      INIT_EULER.y = float(in_array[1]);
      INIT_EULER.z = float(in_array[2]);
      
      SERIAL_BEGUN = true;
    }
    
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


