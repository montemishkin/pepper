PImage bg;
float x = 0;
float d = 100;

float v_y = 0;
float r_y = 0;

float DT = 0.3;

float[] LAYER_POSITIONS = new float[2];
float[] LAYER_SPEEDS = {5, 7};


void setup() {
  size(displayWidth, displayHeight, P3D);

  bg = loadImage("forest1280x800.jpg");
}


void draw() {
  handle_keys();
  if (jumping) {
    r_y += v_y * DT;
    v_y -= 10 * DT; 
    
    if (r_y < 0) {
      r_y = 0;
      v_y = 0;
      jumping = false;
    }
  }
  
//  image(bg, mod(x, width), 0);
//  image(bg, mod(x - bg.width, -width), 0);

  background(0, 200, 200);
  render_layers();
  
  noStroke();
  fill(0);
  ellipse(width/4, height - d/2 - r_y, d, d);
}


// iterate all layer positions
void iterate_layers(float dx) {
  for (int i = 0; i < LAYER_POSITIONS.length; i++) {
    LAYER_POSITIONS[i] += dx * LAYER_SPEEDS[i];
  }
}


// render all layers.  Note, position should already be modded by this point
void render_layers() {
    render_layer_0(LAYER_POSITIONS[0]);
    render_layer_1(LAYER_POSITIONS[1]);
}


// higher numbers are closer to viewer
void render_layer_0(float position) {
  position = mod(position, width);
  float [] xs = {position, position - width};
  float x;
  
  noStroke();
  fill(255);
  
  for (int n = 0; n < xs.length; n++) {
    x = xs[n];
    
    pushMatrix();
      translate(x, 0, 0);
      
      for (int i = 0; i < 10; i++)
        for (int j = 0; j < 10; j++)
          if ((i % 2 == 0) && (j % 3 == 0))
            rect(i * width/10, j * height/10, width/10, height/10);  
    popMatrix();     
  }
}


// higher numbers are closer to viewer
void render_layer_1(float position) {
  position = mod(position, width);
  float [] xs = {position, position - width};
  float x;
  
  noStroke();
  fill(253, 181, 37);
    
  for (int n = 0; n < xs.length; n++) {
    x = xs[n];
  
    pushMatrix();
      translate(x, 0, 0);
      
      rect(0        , 2*height/3, width/10, height);
      rect(width/5  , 1*height/3, width/10, height);
      rect(2*width/5, 7*height/10, width/10, height);
      rect(3*width/5, 1*height/4, width/10, height);
      rect(4*width/5, 7*height/18, width/10, height);
    popMatrix();
  }
}



