void drawUI() {
  fill(0);
  
  //Title
  textFont(neueThin);
  textSize(48);
  text("SakeLight", 10, height / 12);
  textSize(24);
  text("by DolphinTech", 10, height / 12 + 30);
  
  //Left sidebar
  textFont(neueMedium);
  textSize(14);
  text("CURRENT USER", 10, height / 4);
  textFont(neueThin);
  textSize(16);
  text("Josh", 40, height / 4 + 30);
  text("Rina", 40, height / 4 + 60);
  text("Ga Yan", 40, height / 4 + 90);
  text("Macguire", 40, height / 4 + 120);
  
  textFont(neueMedium);
  textSize(14);
  text("THEME", 10, height / 2);
  textFont(neueThin);
  textSize(16);
  text("Sake-Light", 40, height / 2 + 30);
  text("Sake-Dark", 40, height / 2 + 60);
  
  textFont(neueMedium);
  textSize(14);
  text("BACKGROUND", 10, height - height / 4);
  textFont(neueThin);
  textSize(16);
  text("Lava", 40, height - height / 4 + 30);
  text("Stars", 40, height - height / 4 + 60);
  text("Rain", 40, height - height / 4 + 90);
}