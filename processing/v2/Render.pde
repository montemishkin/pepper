/* Notes:
 *   Layer 0 is the farthest background.  Higher numbers are closer to viewer.
 *   Layer -1 is in the foreground.  More negative numbers are closer to viewer.
 *
 */


// render the character only
void render_character() {
  noStroke();
  fill(100);
  ellipse(width/4, height - 100/2 - R_Y, 100, 100);
  //rect(width/4, height - 100 - R_Y, 100, 100);
}


// render all background layers.  Note, position should already be modded by this point
void render_bg_layers() {
    render_layer_0(LAYER_POSITIONS[0]);
    render_layer_1(LAYER_POSITIONS[1]);
    render_layer_2(LAYER_POSITIONS[2]);
}


// stars and/or sun
void render_layer_0(float position) {
  position = mod(position, width);
  float [] xs = {position, position - width};
  float x;
  PVector p; 
  
  color sky = lerpColor(color(0, 200, 200), color(0),
                        map(LIGHT.get_last(), 0, 1023, 1, 0));
  
  noStroke();
  
  background(sky);
  
  for (int n = 0; n < xs.length; n++) {
    x = xs[n];
    
    pushMatrix();
      translate(x, 0, 0);
      
      // sun
      fill(255, 252, 87, map(LIGHT.get_last(), 300, 1023, 0, 255));
      ellipse(9*width/10, height/5, 100, 100);
      
      // stars
      for (int i = 0; i < NUM_STARS; i++) {
        p = STAR_POSITIONS[i];
        fill(255, map(LIGHT.get_last(), 0, 700, 255, 0));
        rect(p.x, p.y, 10, 10);
      }
      
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
      rect(0, height - FLOOR_Y, width, FLOOR_Y);
      
      // a bush
      fill(117, 127, 25);
      rect(7*width/8, height - FLOOR_Y - 80, 102, 80); 
    popMatrix();
  }
}


// render all foreground layers.  Note, position should already be modded by this point
void render_fg_layers() {
  render_layer__1(LAYER_POSITIONS[0]);       // should you have a new positions array?
}


// the grass
void render_layer__1(float position) {
  position = mod(position, width);
  float [] xs = {position, position - width};
  float x;
      
  noStroke();
    
  for (int n = 0; n < xs.length; n++) {
    x = xs[n];
  
    pushMatrix();
      translate(x, 0, 0);
      
      // the grass                            // annoyingly "moves" in time
      fill(61, 109, 15);
      beginShape();
        for (int i = SOUND.get_size() - 1; i >= 0; i--) {
          vertex((i * width / SOUND.get_size()) - x, 
                 map(SOUND.get_ith(i), 0, 1023, height-FLOOR_Y, height-FLOOR_Y-100));
        }
        vertex(-x, height - FLOOR_Y);
        vertex(width - x, height - FLOOR_Y);
      endShape();
      
      // the grass
//      fill(61, 109, 15);
//      rect(0, height - FLOOR_Y - 20, width, 20);
    popMatrix();
  }
}


