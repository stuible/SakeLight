void drawUI() {
  fill(255);
  stroke(1);
  int paddingLeft = 30;
  
  //Title
  textFont(neueThin48);
  text("SakeLight", 10, height / 12);
  textSize(24);
  text("by DolphinTech", 10, height / 12 + 30);
  
  //Welcome message
  text("Welcome, " + currentUser.name + ".", width / 2, 50);
  
  //Left sidebar
  //HEADINGS
  textFont(neueMedium14);
  textSize(14);
  text("CURRENT USER", 10, height / 4);
  text("THEME", 10, height / 2);
  text("BACKGROUND", 10, height - height / 4);
  
  //USERS
  textFont(neueThin16);
  text("Josh", 40, height / 4 + 30);
  text("Rina", 40, height / 4 + 60);
  text("Ga Yan", 40, height / 4 + 90);
  text("Macguire", 40, height / 4 + 120);
  
  //THEME
  text("Sake-Light", 40, height / 2 + 30);
  text("Sake-Dark", 40, height / 2 + 60);
  
  //BACKGROUND
  text("Lava", 40, height - height / 4 + 30);
  text("Stars", 40, height - height / 4 + 60);
  text("Rain", 40, height - height / 4 + 90);
  
  //LABELS
  text("MOTION", width / 3, height / 4 - 20);
  text("VOLUME", width / 2, height / 4 - 80);
  
  //MOTION BAR
  fill(255, 0, 0);
  rect(width / 3, height / 4, 50, height / 2);
  fill(255);
  rect(width / 3, height / 4, 50, height / 2 - motionLevel * 2);
  
  //VOLUME BAR
  fill(0, 255, 0);
  rect(width / 3 + 60, height / 4 - 60, height / 2, 50);
  fill(255);
  rect(width / 3 + 60, height / 4 - 60, height / 2 - volumeLevel, 50);
  
  //INDICATORS
  fill(0, 0, 255, 40);
  noStroke();
  rect(30, currentUserIndicator, 90, 30);
  rect(30, currentThemeIndicator, 90, 30);
  rect(30, currentBackgroundIndicator, 90, 30);
}