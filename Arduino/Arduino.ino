//Motion Variables
int pirPin = 3; //pin the motion sensor is connected to
int val; //voltage of the motion sensor pin
int motionLevel; //current motion level
int volumeLevel; //current volume level
int RFIDid; //id of the last rfid tag scanned


//NFC libraires
#include <SPI.h>
#include "PN532_SPI.h"
#include "PN532.h"
#include "NfcAdapter.h"

//Setup NFC interface
PN532_SPI interface(SPI, 10); // create a PN532 SPI interface with the SPI CS terminal located at digital pin 10
NfcAdapter nfc = NfcAdapter(interface); // create an NFC adapter object

//Pixel Libraries
#include <Adafruit_NeoPixel.h>
#ifdef __AVR__
#include <avr/power.h>
#endif

// Which pin on the Arduino is connected to the NeoPixels?
#define PIN            6

// How many NeoPixels are attached to the Arduino?
#define NUMPIXELS      16

// Setup NeoPixel
Adafruit_NeoPixel pixels = Adafruit_NeoPixel(NUMPIXELS, PIN, NEO_GRB + NEO_KHZ800);

//public Sound
int delayval = 500; // delay for half a second
const int sampleWindow = 50; // Sample window width in mS (50 mS = 20Hz)
unsigned int sample;
unsigned int peakToPeak = 0;   // peak-to-peak level

void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  nfc.begin(); // begin NFC communication
  motionLevel = 0;
  volumeLevel = 50;
  RFIDid = 0;
}

void loop() {


  checkMotion();

  getSoundInput();

  checkNFC();

  delay(1000);
}
