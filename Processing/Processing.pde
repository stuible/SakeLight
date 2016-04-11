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
User Josh = new User("Josh");
User Rina = new User("Rina");
User GaYan = new User("GaYan");
User Macguire = new User("Macguire");
User currentUser;
char inBuffer; 
boolean RFID; //i don't think we use this at all
int volumeLevel; //the current volume level
int motionLevel; //the current motion level
int currentUserIndicator; //y-value for current user indicator
int currentThemeIndicator; //y-value for current theme indicator
int currentBackgroundIndicator; //y-value for current background indicator
int RFIDid; //stores the last RFID tag scanned
color blue = color(0, 0, 200);
color green = color(0, 200, 0);

//FONTS
PFont neueThin48;
PFont neueThin16;
PFont neueMedium14;

//LAVA BACKGROUND
//Source: http://www.openprocessing.org/sketch/173035
color i1, i2, f1, f2, c1, c2;
int i = 0;
int R = 255;
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

void setup () {
  String portName = Serial.list()[1]; //set port
  myPort = new Serial(this, portName, 9600); //instantiate port
  size(1024, 700);
  surface.setResizable(true);
  neueThin48 = loadFont("NeueThin48.vlw");
  neueThin16 = loadFont("NeueThin16.vlw");
  neueMedium14 = loadFont("NeueMedium14.vlw");
  textSize(24);
  currentUser = Josh;
  currentUserIndicator = height / 4 + 10;
  currentThemeIndicator = height / 2 + 40;
  currentBackgroundIndicator = height - height / 4 + 10;
  
  //LAVA
  i1 = color(random(R), random(R), random(R));
  i2 = color(random(R), random(R), random(R));
  c1 = i1;
  c2 = f2;
  f1 = i1;
  f2 = i2;
  
  //WAVE BACKGROUND
  w = width+16;
  dx = (TWO_PI / period) * xspacing;
  yvalues = new float[w/xspacing];
}

void draw() {
  drawBackground(currentUser.background, currentUser.theme);
  
  drawUI();
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
    currentBackgroundIndicator = height - height / 4 + 10;
  } else if (mouseY > height - height / 4 + 40 && mouseY < height - height / 4 + 70 && mouseX > 30 && mouseX < 120) {
    currentUser.background = "Stars";
    currentBackgroundIndicator = height - height / 4 + 40;
  } else if (mouseY > height - height / 4 + 70 && mouseY < height - height / 4 + 100 && mouseX > 30 && mouseX < 120) {
    currentUser.background = "Rain";
    currentBackgroundIndicator = height - height / 4 + 70;
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
    
    f1 = color(random(R), random(R), random(R));
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