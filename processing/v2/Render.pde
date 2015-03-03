/* Notes:
 *   Layer 0 is the farthest background.  Higher numbers are closer to viewer.
 *
 */


// render the character only
void render_character() {
  noStroke();
  fill(0);
  ellipse(width/4, height - 100/2 - R_Y, 100, 100);
  //rect(width/4, height - 100 - R_Y, 100, 100);
}


// render all layers.  Note, position should already be modded by this point
void render_layers() {
    render_layer_0(LAYER_POSITIONS[0]);
    render_layer_1(LAYER_POSITIONS[1]);
    render_layer_2(LAYER_POSITIONS[2]);
}


// clouds
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
            rect(i * width/10, j * height/10, 20, 20);  
    popMatrix();     
  }
}


// pillars
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
      
      rect(0        , 2*height/3 , width/10, height);
      rect(width/5  , 1*height/3 , width/10, height);
      rect(2*width/5, 7*height/10, width/10, height);
      rect(3*width/5, 1*height/4 , width/10, height);
      rect(4*width/5, 7*height/18, width/10, height);
    popMatrix();
  }
}


// floor, grass, bush 
void render_layer_2(float position) {
  position = mod(position, width);
  float [] xs = {position, position - width};
  float x;
  
  noStroke();
    
  for (int n = 0; n < xs.length; n++) {
    x = xs[n];
  
    pushMatrix();
      translate(x, 0, 0);
      
      // the floor
      fill(189, 102, 187);
      rect(0, height - FLOOR_Y + 20, width, FLOOR_Y + 20);
      // the grass
      fill(61, 109, 15);
      rect(0, height - FLOOR_Y, width, 20);
      // a bush
      fill(117, 127, 25);
      rect(7*width/8, height - FLOOR_Y - 80, 102, 80); 
    popMatrix();
  }
}


