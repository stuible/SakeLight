void drawBackground(String bg) {
  if (bg.equals("Lava")) {
    background(255, 0, 0);
  } else if (bg.equals("Stars")) {
    background(0, 255, 0);
  } else if (bg.equals("Rain")) {
    background(0, 0, 255);
  }
}