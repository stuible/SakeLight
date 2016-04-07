//Import Libraries
import processing.serial.*;

//Serial Variables
Serial myPort;  // Create object from Serial class

//Public Variables
String val;     // Data received from the serial port
String myString = null;
char inBuffer;
boolean motionDetected;
boolean RFID;
int volumeLevel;
int motionLevel;
int lastMotionLevel;
int RFIDid;
color blue = color(0, 0, 200);
color green = color(0, 200, 0);

void setup () {
  String portName = Serial.list()[1]; //set port
  myPort = new Serial(this, portName, 9600); //instantiate port
  size(800, 600);
  textSize(24);
}


void draw() {
  background(255);
  setSerialValues();  

  //TEXT
  fill(0);
  text("Gekkeikan", 0, 20);
  text("by DolphinTech", 0, 50);
  text("Volume: " + volumeLevel, 100, 250);
  text("Motion: " + motionLevel, 400, 250);
  
  if(motionDetected){
    text("Motion is detected", 400, 300);
  } 
  else{
    text("Everybody chillin", 400, 300);
  }
  
  if(RFIDid == 12){
  text("Welcome Josh", width / 2, 400);
  }
  else if(RFIDid == 2){
  text("Welcome Macguire", width / 2 - 100, 400);
  }

  drawBar(volumeLevel, 100, 100, 50, 100, blue); //volume bar
  drawBar(motionLevel * 2, 400, 100, 50, 100, green); //motion bar
}