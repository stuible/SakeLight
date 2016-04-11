void drawBackground(String bg, String theme) {
  if (bg.equals("Lava") && theme.equals("Dark")) {
    R = 150;
    Rlow = 0;
    textColor = color(255);
    currentBackgroundIndicator = height - height / 4 + 10;
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
    R = 255;
    Rlow = 150;
    textColor = 0;
    currentBackgroundIndicator = height - height / 4 + 10;
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
  } else if (bg.equals("Stars") && theme.equals("Light")) {
    currentBackgroundIndicator = height - height / 4 + 40;
    background(255);
    textColor = color(0);
    fill(0);
    ellipseMode(CENTER);
    ellipse(mouseX, mouseY, 10, 10);
  
    for (int i = 0; i<itemNum; i++) {
      items[i].move();
      items[i].proxy();
      items[i].display();
    }
  } else if (bg.equals("Stars") && theme.equals("Dark")) {
    currentBackgroundIndicator = height - height / 4 + 40;
    background(0);
    textColor = color(255);
    fill(200, 100, 50);
    ellipseMode(CENTER);
    ellipse(mouseX, mouseY, 10, 10);
  
    for (int i = 0; i<itemNum; i++) {
      items[i].move();
      items[i].proxy();
      items[i].display();
    }
  } else if (bg.equals("Rain") && theme.equals("Light")) {
    currentBackgroundIndicator = height - height / 4 + 70;
    textColor = color(0);
    background(255, 50);
    fill(255,1);
    rect(0,0,width,height);
    calcWave();
    renderWave();
  } else if (bg.equals("Rain") && theme.equals("Dark")) {
    currentBackgroundIndicator = height - height / 4 + 70;
    textColor = color(255);
    background(0, 50);
    fill(255,1);
    rect(0,0,width,height);
    calcWave();
    renderWave();
  }
}