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
int pirPin = 3; //pin the motion sensor is connected to
int val; //voltage of the motion sensor pin
int motionLevel; //current motion level
int volumeLevel; //current volume level
int RFIDid; //id of the last rfid tag scanned

//Light Variables

void setup() {
  Serial.begin(9600); //begin serial communication at 9600 baud
  pinMode(13, OUTPUT);
  nfc.begin(false); // begin NFC communication
  pixels.begin(); // initialize the NeoPixel library.
  motionLevel = 0;
  RFIDid = 0;
}

void loop() {
  //Serial monitor displays data in the format:
  //&motionLevel&volumeLevel&RFIDid&
  startSerial();

  checkMotion(); //reads the state of the motion sensor
  checkSoundInput(); //reads the state of the microphone
  checkNFC(); //reads the state of the NFC sensor
  updateLight(); //updates the light accordingly

  endSerial(); //prints the serial line so processing can recieve it

  delay(10); //delay for speed of checks/updates
}
