void drawBar(int v, int x, int y, int w, int h, color c){
  fill(c);
  rect(x, y, w, h);
  fill(255);
  rect(x, y, w, h - v);
}