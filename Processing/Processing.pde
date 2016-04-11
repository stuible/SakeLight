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
  currentThemeIndicator = height / 2 + 10; 
  currentBackgroundIndicator = height - height / 4 + 10;
}

void draw() {
  drawBackground(currentUser.background);
  //if (currentUser.background.equals("Lava")) {
    
  //} else if (currentUser.background.equals("Stars")) {
  //  drawStars();
  //} else if (currentUser.background.equals("Rain")) {
  //  drawRain();
  //}
  
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
    currentUser.theme = "light";
  } else if (mouseY > height / 2 + 40 && mouseY < height / 2 + 70 && mouseX > 30 && mouseX < 120) {
    currentUser.theme = "dark";
  }
}