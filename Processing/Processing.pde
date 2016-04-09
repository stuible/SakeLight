//Import Libraries
import processing.serial.*;

//Serial Variables
Serial myPort;  // Create object from Serial class

//Public Variables
String val;     // Data received from the serial port
String myString = null;
String currentUser; //the name of the current user
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
  size(1024, 768);
  surface.setResizable(true);
  neueThin48 = loadFont("NeueThin48.vlw");
  neueThin16 = loadFont("NeueThin16.vlw");
  neueMedium14 = loadFont("NeueMedium14.vlw");
  textSize(24);
  currentUserIndicator = height / 4 + 10;
  currentThemeIndicator = height / 2 + 10; 
  currentBackgroundIndicator = height - height / 4 + 10;
}

void draw() {
  background(255);
  drawUI();
  setSerialValues();
  
  if(RFIDid == 12){
    currentUser = "Josh";
    currentUserIndicator = height / 4 + 10;
  } else if(RFIDid == 2){
    currentUser = "Macguire";
    currentUserIndicator = height / 4 + 100;
  }
}