color textColor = color(255);

void drawUI() {
  textAlign(LEFT);
  cursor();
  
  //INDICATORS
  fill(0, 0, 255, 40);
  noStroke();
  rect(30, currentUserIndicator, 90, 30);
  rect(30, currentThemeIndicator, 90, 30);
  rect(30, currentBackgroundIndicator, 90, 30);
  
  fill(textColor);
  stroke(1);
  int paddingLeft = 25;
  
  //Title
  textFont(neueThin48);
  text("Sakenomi", paddingLeft, height / 12);
  textSize(24);
  text("by DolphinTech", paddingLeft, height / 12 + 30);
  
  //Welcome message
  text(hour() + ":" + minuteString + "   |   " + monthString + " " + day + ", " + year(), width / 2, 50);
  
  //Left sidebar
  //HEADINGS
  textFont(neueMedium14);
  textSize(14);
  text("CURRENT USER", paddingLeft, height / 4);
  text("THEME", paddingLeft, height / 2);
  text("BACKGROUND", paddingLeft, height - height / 4);
  
  //USERS
  textFont(neueThin16);
  text("Helmine", 40, height / 4 + 30);
  text("Rina", 40, height / 4 + 60);
  text("Ga Yan", 40, height / 4 + 90);
  text("Maryam", 40, height / 4 + 120);
  
  //THEME
  text("Sake-Light", 40, height / 2 + 30);
  text("Sake-Dark", 40, height / 2 + 60);
  
  //BACKGROUND
  text("Lava", 40, height - height / 4 + 30);
  text("Stars", 40, height - height / 4 + 60);
  text("Rain", 40, height - height / 4 + 90);
  
  //LABELS
  text("MOTION", width / 4, height / 2);
  text("VOLUME", width / 2, height - height / 5);
  
  //COLORMAP
  //image(colormap, width / 3, height / 4, height / 2, height / 2);
  
  noStroke();
  //MOTION + VOLUME AXES
  stroke(textColor);
  line(width / 3, height / 4, width / 3, height / 4 + 350);
  line(width / 3, height / 4 + 350, width / 3 + 350, height / 4 + 350);
  
  //LINE FROM MOTION
  line(width / 3, height - height / 4 - motionLevel * 3, width / 3 + 60 + volumeLevel * 2 + 20, height - height / 4 - motionLevel * 3);
  
  //LINE FROM VOLUME
  line(width / 3 + 60 + volumeLevel * 2, height - height / 4 - motionLevel * 3 - 20, width / 3 + 60 + volumeLevel * 2, height / 4 + 350);
  
  noStroke();
  fill(textColor, 50);
  ellipse(width / 3 + 60 + volumeLevel * 2, height - height / 4 - motionLevel * 3, 20, 20);
}