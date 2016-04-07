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
  String portName = Serial.list()[1]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 9600); 

  //variable for motion level
  //variable for volume level
  size(800, 600);
  textSize(24);
}


void draw() {
  background(255);
  //SERIAL COMMUNICATION
  while (myPort.available() > 0) {
    String myString = myPort.readStringUntil(10);

    if (myString != null) {
      myString = trim(myString);

      // split the string at the tabs and convert the sections into integers:
      int[] mysensors = int(splitTokens(myString, "&"));

      try {
        motionLevel = mysensors[0];
        volumeLevel = mysensors[1];
        RFIDid = mysensors[2];
      } catch (Exception e) {
      
      }
    }
  }
  
  try {
  println("Motion level: " + motionLevel);
  println("Volume level: " + volumeLevel);
  
  println("RFID ID: " + RFIDid);
  } catch (Exception e) {
  }
  //TEXT
  fill(0);
  text("Gekkeikan", 0, 20);
  text("by DolphinTech", 0, 50);
  text("Volume: " + volumeLevel, 100, 250);
  text("Motion: " + motionLevel, 400, 250);
  if (motionDetected) {
    text("Motion is detected", 400, 300);
  } else {
    text("Everybody chillin", 400, 300);
  }

  //VOLUME BAR
  fill(blue);
  rect(100, 100, 50, 100);
  fill(255);
  rect(100, 100, 50, 100 - volumeLevel);

  //MOTION BAR
  fill(green);
  rect(400, 100, 50, 100);
  fill(255);
  rect(400, 100, 50, 100 - motionLevel * 2);
}