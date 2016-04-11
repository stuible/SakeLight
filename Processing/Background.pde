void drawBackground(String bg, String theme) {
  if (bg.equals("Lava") && theme.equals("Dark")) {
    //LAVA BACKGROUND
    //Source: http://www.openprocessing.org/sketch/173035
    if ( red(c1) == red(f1) && green(c1) == green(f1) && blue(c1) == blue(f1) ) {
      pickNewColor();
    }
  
    i++;
  
    // make gradient
    float inter = map(i, 0, v, 0,1); 
    c1 = lerpColor(i1, f1, inter);
    c2 = lerpColor(i2, f2, inter);
    setGradient(0, 0, width, height, c1, c2);
  } else if (bg.equals("Lava") && theme.equals("Light")) {
    //LAVA BACKGROUND
    //Source: http://www.openprocessing.org/sketch/173035
    if ( red(c1) == red(f1) && green(c1) == green(f1) && blue(c1) == blue(f1) ) {
      pickNewColor();
    }
  
    i++;
  
    // make gradient
    float inter = map(i, 0, v, 0,1); 
    c1 = lerpColor(i1, f1, inter);
    c2 = lerpColor(i2, f2, inter);
    setGradient(0, 0, width, height, c1, c2);
  } else if (bg.equals("Stars")) {
    time += dt;
    background(255);
    noStroke();
    fill(255, 0, 0, 1);
    for (float y=-50; y<height-50; y+=dy) {
      beginShape();
      vertex(0, height);
      for (float x=0; x<=width; x+=1) {
        float drift = noise(x/300, y/300, time)*500;
        vertex(x, y+drift +350);
      }
      vertex(width, height);
      endShape();
    }
  } else if (bg.equals("Rain")) {
    background(0, 0, 255);
  }
}