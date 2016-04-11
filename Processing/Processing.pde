//  +++++++++++++++++++++++
//  +   SakeLight         +
//  +   by DolphinTech    +
//  +                     +
//  +   IAT 267 - D102    +
//  +   Josh Stuible      +
//  +   Macguire Rintoul  +
//  +   Rina Shimohashi   +
//  +   Ga Yan Yip        +
//  +++++++++++++++++++++++

//Import Libraries
import processing.serial.*;

//Serial Variables
Serial myPort;  // Create object from Serial class

//Public Variables
String val;     // Data received from the serial port
String myString = null;
String background; //the currently chosen background
String monthString = null;
String minuteString = null;
User Maryam = new User("Maryam");
User Josh = new User("Josh");
User Rina = new User("Rina");
User GaYan = new User("GaYan");
User Macguire = new User("Macguire");
User currentUser;
char inBuffer; 
boolean joshUI;
boolean RFID; //i don't think we use this at all
int volumeLevel; //the current volume level
int motionLevel1; //motion level from motion sensor 1
int motionLevel2; //motion level from motion sensor 2
int motionAtmosphere;
int volumeAtmosphere;
int currentUserIndicator; //y-value for current user indicator
int currentThemeIndicator; //y-value for current theme indicator
int currentBackgroundIndicator; //y-value for current background indicator
int RFIDid; //stores the last RFID tag scanned
int day = day();
int minute = minute();
int screenSaver = 500;
color blue = color(0, 0, 200);
color green = color(0, 200, 0);


int[] serialRGB = new int[6];


//FONTS
PFont neueThin48;
PFont neueThin16;
PFont neueMedium14;
PFont arial;

//IMAGES
PImage colormap;

//LAVA BACKGROUND
//Source: http://www.openprocessing.org/sketch/173035
color i1, i2, f1, f2, c1, c2;
int i = 0;
int R = 255;
int Rlow = 0;
int v = 150;

//SMOKE BACKGROUND
//Source: http://www.openprocessing.org/sketch/199433
float time = 0;
float dy = 2, dt = 0.02;

//WAVE BACKGROUND
//Source: http://www.openprocessing.org/sketch/1012
int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
float theta = 0.0f;       // Start angle at 0
float amplitude = 175.0f;  // Height of wave
float period = 500.0f;    // How many pixels before the wave repeats
float dx;                 // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues; 

//CONSTELLATIONS
int itemNum = 150;
float friction = -0.3;
Item[] items = new Item[itemNum];

void setup () {
  String portName = Serial.list()[1]; //set port
  myPort = new Serial(this, portName, 9600); //instantiate port
  fullScreen();
  //size(1024, 700);
  surface.setResizable(true);
  neueThin48 = loadFont("NeueThin48.vlw");
  neueThin16 = loadFont("NeueThin16.vlw");
  neueMedium14 = loadFont("NeueMedium14.vlw");
  colormap = loadImage("colormap.jpg");
  textSize(24);
  textAlign(LEFT);
  currentUser = Maryam;
  currentUserIndicator = height / 4 + 10;
  currentThemeIndicator = height / 2 + 40;
  currentBackgroundIndicator = height - height / 4 + 10;
  joshUI = true;
  
  //LAVA
  i1 = color(random(Rlow, R), random(Rlow, R), random(Rlow, R));
  i2 = color(random(Rlow, R), random(Rlow, R), random(Rlow, R));
  c1 = i1;
  c2 = f2;
  f1 = i1;
  f2 = i2;
  
  //WAVE BACKGROUND
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
  
  //CONSTELLATIONS
  for (int i=0; i<itemNum; i++) {
    items[i] = new Item(0, 0, random(2, 4), i, items);
  }
}

void draw() {
  //TESTING
  motionLevel1 = (int) random(80, 85);
  volumeLevel = (int) random(80, 85);
  
  //FOR DATE
  if (month() == 4) {
    monthString = "April";
  }
  minute = minute();
  if (minute() < 10) {
    minuteString = "0" + minute;
  } else {
    minuteString = "" + minute;
  }
  
  screenSaver--;
  if (screenSaver == 0) {
    joshUI = true;
  }
  
  drawBackground(currentUser.background, currentUser.theme);
  if (!joshUI) {
    drawUI();
  } else {
    joshUI();
  }
  
  setSerialValues();
  
  if(RFIDid == 12) {
    currentUser = Josh;
    currentUserIndicator = height / 4 + 10;
  } else if(RFIDid == 2) {
    currentUser = Macguire;
    currentUserIndicator = height / 4 + 100;
  }
}

void mouseClicked() {
  //BACKGROUND
  if (mouseY > height - height / 4 + 10 && mouseY < height - height / 4 + 40 && mouseX > 30 && mouseX < 120) {
    currentUser.background = "Lava";
  } else if (mouseY > height - height / 4 + 40 && mouseY < height - height / 4 + 70 && mouseX > 30 && mouseX < 120) {
    currentUser.background = "Stars";
  } else if (mouseY > height - height / 4 + 70 && mouseY < height - height / 4 + 100 && mouseX > 30 && mouseX < 120) {
    currentUser.background = "Rain";
  }
  
  //CURRENT USER
  if (mouseY > height / 4 + 10 && mouseY < height / 4 + 40 && mouseX > 30 && mouseX < 120) {
    currentUser = Josh;
    currentUserIndicator = height / 4 + 10;
  } else if (mouseY > height / 4 + 40 && mouseY < height / 4 + 70 && mouseX > 30 && mouseX < 120) {
    currentUser = Rina;
    currentUserIndicator = height / 4 + 40;
  } else if (mouseY > height / 4 + 70 && mouseY < height / 4 + 100 && mouseX > 30 && mouseX < 120) {
    currentUser = GaYan;
    currentUserIndicator = height / 4 + 70;
  } else if (mouseY > height / 4 + 100 && mouseY < height / 4 + 130 && mouseX > 30 && mouseX < 120) {
    currentUser = Macguire;
    currentUserIndicator = height / 4 + 100;
  }
  
  //THEME
  if (mouseY > height / 2 + 10 && mouseY < height / 2 + 40 && mouseX > 30 && mouseX < 120) {
    currentUser.theme = "Light";
    currentThemeIndicator = height / 2 + 10;
  } else if (mouseY > height / 2 + 40 && mouseY < height / 2 + 70 && mouseX > 30 && mouseX < 120) {
    currentUser.theme = "Dark";
    currentThemeIndicator = height / 2 + 40;
  }
}

void pickNewColor(){
    
    i1 = f1;
    i2 = f2;
    
    f1 = color(random(Rlow, R), random(Rlow, R), random(Rlow, R));
    f2 = lerpColor(i1, i2, 0.5);  
    
    i =0;
}

void setGradient(int x, int y, float w, float h, color c1, color c2 ) {
  for (int i = y; i <= y+h; i++) {
    float inter = map(i, y, y+h, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(x, i, x+w, i);
  }
}

void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02;
 
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}
 
void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  for ( int x = 0; x < yvalues.length; x++ ) {
    stroke( 255, x, 0, 5);
    fill(255, 0 , 0, 1);
    ellipseMode( CENTER );
    ellipse( x*xspacing,width/2+yvalues[x],yvalues[(x+x)%77],yvalues[(x+x+x)%77] );
  }
}

void joshUI() {
  noCursor();
  textAlign(CENTER);
  textFont(neueThin48);
  fill(255);
  text("Hey, " + currentUser.name + ". It's " + hour() + ":" + minuteString + ".   |   " + monthString + " " + day + ", " + year(), width / 2, height / 2);
  textFont(neueThin16);
  text("[a] to show UI", width / 2, height - height / 4);
}

void keyPressed() {
  if (key == 'a') {
    screenSaver = 500;
    if (joshUI) {
      joshUI = false;
    } else if (!joshUI) {
      joshUI = true;
    }
  }
}

void mouseMoved() {
  screenSaver = 500;
}