//NFC libraires
#include <SPI.h>
#include "PN532_SPI.h"
#include "PN532.h"
#include "NfcAdapter.h"

//Pixel Libraries
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
#include <avr/power.h>
#endif

//Setup NFC interface
PN532_SPI interface(SPI, 10); // create a PN532 SPI interface with the SPI CS terminal located at digital pin 10
NfcAdapter nfc = NfcAdapter(interface); // create an NFC adapter object

// Setup NeoPixel
#define PIN            6 // Arduino pin connected to the NeoPixels
#define NUMPIXELS      16 // Number of NeoPixels attached to the Arduino
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

//Sound Variables
int delayval = 500; // delay for half a second
const int sampleWindow = 50; // Sample window width in mS (50 mS = 20Hz)
unsigned int sample;
unsigned int peakToPeak = 0;   // peak-to-peak level

//Motion Variables
int pirPin1 = 2; //pin the motion sensor is connected to
int pirPin2 = 3;
int val; //voltage of the motion sensor pin
int motionLevel; //current motion level
int volumeLevel; //current volume level
int RFIDid; //id of the last rfid tag scanned

//Atmosphere Variables
int volumeAtmosphere;
int motionAtmosphere;
int PersonalAtmosphere;
int atmosphereTimer;
int atmosphereCounter;
int volumeAverage;
int motionAverage;

int averagesLength = 30;
int volumeAverages[30];
int motionAverages[30];

//Light Colours
int black[3]  = { 0, 0, 0 };
int white[3]  = { 200, 200, 200 };
int red[3]    = { 200, 0, 0 };
int green[3]  = { 0, 200, 0 };
int blue[3]   = { 0, 0, 200 };
int purple[3]   = { 200, 0, 200 };
int yellow[3] = { 255, 255, 0 };
int orange[3] = { 255, 204, 0 };
int pink[3] = { 255, 192, 203 };

int lightColour[3];
int startColour[3];
int endColour[3];
int changeTimer;
int timeToChange;
boolean changingColour = false;
boolean pulse1;
boolean firstColourPulse;
int colourID;
// Set initial color



void setup() {
  Serial.begin(9600); //begin serial communication at 9600 baud
  pinMode(13, OUTPUT);
  nfc.begin(false); // begin NFC communication
  pixels.begin(); // initialize the NeoPixel library.
  motionLevel = 0;
  RFIDid = 0;
  changeColour(black, blue, 50);
}

void loop() {
  //Serial monitor displays data in the format:
  //&motionLevel&volumeLevel&RFIDid&
  startSerial();

  checkMotion(); //reads the state of the motion sensor
  checkSoundInput(); //reads the state of the microphone
  checkNFC(); //reads the state of the NFC sensor
  updateAtmosphere();
  updateColour();
  updateLight();

  endSerial(); //prints the serial line so processing can recieve it
  
  delay(33); //delay for speed of checks/updates
}
