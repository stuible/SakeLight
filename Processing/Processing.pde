//Import Libraries
import processing.serial.*;

//Serial Variables
Serial myPort;  // Create object from Serial class

//Public Variables
String val;     // Data received from the serial port
String myString = null;
String currentUser;
char inBuffer;
boolean motionDetected;
boolean RFID;
int volumeLevel;
int motionLevel;
int RFIDid;
color blue = color(0, 0, 200);
color green = color(0, 200, 0);
PFont neueThin;
PFont neueMedium14;

void setup () {
  String portName = Serial.list()[1]; //set port
  myPort = new Serial(this, portName, 9600); //instantiate port
  size(1024, 768);
  surface.setResizable(true);
  neueThin = loadFont("NeueThin.vlw");
  neueMedium14 = loadFont("NeueMedium14.vlw");
  textSize(24);
}


void draw() {
  background(255);
  drawUI();
  setSerialValues();
  
  //TEXT
  fill(0);
  text("Volume: " + volumeLevel, 100, 250);
  text("Motion: " + motionLevel, 400, 250);
  
  if(motionDetected){
    text("Motion is detected", 400, 300);
  } 
  else{
    text("Everybody chillin", 400, 300);
  }
  
  if(RFIDid == 12){
    currentUser = "Josh";
  text("Welcome Josh", width / 2, 400);
  }
  else if(RFIDid == 2){
    currentUser = "Macguire";
  text("Welcome Macguire", width / 2 - 100, 400);
  }

  drawBar(volumeLevel, 100, 100, 50, 100, blue); //volume bar
  drawBar(motionLevel * 2, 400, 100, 50, 100, green); //motion bar
}