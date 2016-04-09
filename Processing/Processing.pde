//Import Libraries
import processing.serial.*;

//Serial Variables
Serial myPort;  // Create object from Serial class

//Public Variables
String val;     // Data received from the serial port
String myString = null;
String currentUser;
char inBuffer;
boolean RFID;
int volumeLevel;
int motionLevel;
int currentUserIndicator;
int RFIDid;
color blue = color(0, 0, 200);
color green = color(0, 200, 0);
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
  currentUserIndicator = height / 4;
}

void draw() {
  background(255);
  drawUI();
  setSerialValues();
  
  if(RFIDid == 12){
    currentUser = "Josh";
    text("Welcome Josh", width / 2, 400);
  } else if(RFIDid == 2){
    currentUser = "Macguire";
    text("Welcome Macguire", width / 2 - 100, 400);
  }
}