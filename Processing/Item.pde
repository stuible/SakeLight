//item class for constellation background
class Item {

  float x, y;
  float vx = 0;
  float vy = 0;
  float a = 0;
  float diameter = 0;
  float speed = 0;
  int id;
  Item[] others;

  Item(float xin, float yin, float din, int idin, Item[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    int id;
    others = oin;
  }

  void display() {
    fill(150, 155);
    noStroke();
    ellipse(x, y, diameter, diameter);
  }

  void move() {
    //damping
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction; 
    }else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
    //follow mousex, mousey
    pushMatrix();
    float px = mouseX - x;
    float py = pmouseY - y;
    a = atan2(py, px);
    rotate(a);
    speed = random(1, 5);
    x += (cos(a)*speed);
    y += (sin(a)*speed);
    popMatrix();
  }
  //Thanks to Keith Peters
  void proxy() {
    for (int i = id + 1; i < itemNum; i++) {
      //get distance
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      //collision test 
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * 0.05;
        float ay = (targetY - others[i].y) * 0.05;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
      //proximity test
      stroke(150, 55);
      if (distance < 50) {
        line(x, y, others[i].x, others[i].y);
      }
    }
  }
}