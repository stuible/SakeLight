void drawBackground(String bg, String theme) {
  if (bg.equals("Lava") && theme.equals("Dark")) {
    background(100, 0, 0);
  } else if (bg.equals("Lava") && theme.equals("Light")) {
    background(250, 0, 0);
  } else if (bg.equals("Stars")) {
    background(0, 255, 0);
  } else if (bg.equals("Rain")) {
    background(0, 0, 255);
  }
}