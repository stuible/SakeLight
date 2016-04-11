import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.serial.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Processing extends PApplet {

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
int blue = color(0, 0, 200);
int green = color(0, 200, 0);

//FONTS
PFont neueThin48;
PFont neueThin16;
PFont neueMedium14;

//LAVA BACKGROUND
//Source: http://www.openprocessing.org/sketch/173035
int i1, i2, f1, f2, c1, c2;
int i = 0;
int R = 255;
int v = 150;

//SMOKE BACKGROUND
//Source: http://www.openprocessing.org/sketch/199433
float time = 0;
float dy = 2, dt = 0.02f;

//WAVE BACKGROUND
//Source: http://www.openprocessing.org/sketch/1012
int xspacing = 8;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
float theta = 0.0f;       // Start angle at 0
float amplitude = 175.0f;  // Height of wave
float period = 500.0f;    // How many pixels before the wave repeats
float dx;                 // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues; 

public void setup () {
  frameRate(10);
  String portName = Serial.list()[1]; //set port
  myPort = new Serial(this, portName, 9600); //instantiate port
  
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

public void draw() {
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

public void mouseClicked() {
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

public void pickNewColor(){
    
    i1 = f1;
    i2 = f2;
    
    f1 = color(random(R), random(R), random(R));
    f2 = lerpColor(i1, i2, 0.5f);  
    
    i =0;
}

public void setGradient(int x, int y, float w, float h, int c1, int c2 ) {
 
 for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      int c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
 }
 
}

public void calcWave() {
  // Increment theta (try different values for 'angular velocity' here
  theta += 0.02f;
 
  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = sin(x)*amplitude;
    x+=dx;
  }
}
 
public void renderWave() {
  // A simple way to draw the wave with an ellipse at each location
  for ( int x = 0; x < yvalues.length; x++ ) {
    stroke( 255, x, 0, 5);
    fill(255, 0 , 0, 1);
    ellipseMode( CENTER );
    ellipse( x*xspacing,width/2+yvalues[x],yvalues[(x+x)%77],yvalues[(x+x+x)%77] );
  }
}
public void drawBackground(String bg, String theme) {
  if (bg.equals("Lava") && theme.equals("Dark")) {
    //LAVA BACKGROUND
    //Source: http://www.openprocessing.org/sketch/173035
    if ( red(c1) == red(f1) && green(c1) == green(f1) && blue(c1) == blue(f1) ) {
      pickNewColor();
    }
  
    i++;
  
    // make gradient
    float inter = map(i, 0, v, 0,1); 
    c1 = lerpColor(i1, f1, inter);
    c2 = lerpColor(i2, f2, inter);
    setGradient(0, 0, width, height, c1, c2);
  } else if (bg.equals("Lava") && theme.equals("Light")) {
    //LAVA BACKGROUND
    //Source: http://www.openprocessing.org/sketch/173035
    if ( red(c1) == red(f1) && green(c1) == green(f1) && blue(c1) == blue(f1) ) {
      pickNewColor();
    }
  
    i++;
  
    // make gradient
    float inter = map(i, 0, v, 0,1); 
    c1 = lerpColor(i1, f1, inter);
    c2 = lerpColor(i2, f2, inter);
    setGradient(0, 0, width, height, c1, c2);
  } else if (bg.equals("Stars")) {
    time += dt;
    background(255);
    noStroke();
    fill(255, 0, 0, 1);
    for (float y=-50; y<height-50; y+=dy) {
      beginShape();
      vertex(0, height);
      for (float x=0; x<=width; x+=1) {
        float drift = noise(x/300, y/300, time)*500;
        vertex(x, y+drift +350);
      }
      vertex(width, height);
      endShape();
    }
  } else if (bg.equals("Rain")) {
    background(255, 50);
    fill(255,1);
    rect(0,0,width,height);
    calcWave();
    renderWave();
  }
}
public void drawBar(int v, int x, int y, int w, int h, int c){
  fill(c);
  rect(x, y, w, h);
  fill(255);
  rect(x, y, w, h - v);
}
public void setSerialValues(){
  while (myPort.available() > 0) {
    String myString = myPort.readStringUntil(10);

    if(myString != null){
      myString = trim(myString);

      // split the string at the tabs and convert the sections into integers:
      int[] mysensors = PApplet.parseInt(splitTokens(myString, "&"));

      try{
        motionLevel = mysensors[0];
        volumeLevel = mysensors[1];
        RFIDid = mysensors[2];
        
        println("Motion level: " + motionLevel);
        println("Volume level: " + volumeLevel);
        println("NFC ID: " + RFIDid);
      } 
      catch(Exception e){
        println("Sensors Unavailable");
      }
    }
  }
}
class User {
  String name;
  String theme = "Dark";
  String background = "Lava";
  
  User(String name_init) {
     name = name_init;
  }
}
public void drawUI() {
  fill(255);
  stroke(1);
  int paddingLeft = 30;
  
  //Title
  textFont(neueThin48);
  text("SakeLight", paddingLeft, height / 12);
  textSize(24);
  text("by DolphinTech", paddingLeft, height / 12 + 30);
  
  //Welcome message
  text("Welcome, " + currentUser.name + ".", width / 2, 50);
  
  //Left sidebar
  //HEADINGS
  textFont(neueMedium14);
  textSize(14);
  text("CURRENT USER", paddingLeft, height / 4);
  text("THEME", paddingLeft, height / 2);
  text("BACKGROUND", paddingLeft, height - height / 4);
  
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
  public void settings() {  size(1024, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
