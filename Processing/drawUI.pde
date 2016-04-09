void drawUI() {
  fill(0);
  
  //Title
  textFont(neueThin);
  textSize(48);
  text("SakeLight", 10, height / 12);
  textSize(24);
  text("by DolphinTech", 10, height / 12 + 30);
  
  //Welcome message
  text("Welcome, " + currentUser + ".", width / 2, 50);
  
  //Left sidebar
  //HEADINGS
  textFont(neueMedium14);
  textSize(14);
  text("CURRENT USER", 10, height / 4);
  text("THEME", 10, height / 2);
  text("BACKGROUND", 10, height - height / 4);
  
  //USERS
  textFont(neueThin);
  textSize(16);
  text("Josh", 40, height / 4 + 30);
  text("Rina", 40, height / 4 + 60);
  text("Ga Yan", 40, height / 4 + 90);
  text("Macguire", 40, height / 4 + 120);
  
  //THEME
  textFont(neueThin);
  textSize(16);
  text("Sake-Light", 40, height / 2 + 30);
  text("Sake-Dark", 40, height / 2 + 60);
  
  //BACKGROUND
  textFont(neueThin);
  textSize(16);
  text("Lava", 40, height - height / 4 + 30);
  text("Stars", 40, height - height / 4 + 60);
  text("Rain", 40, height - height / 4 + 90);
}