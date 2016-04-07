//MOTION
int pirPin = 3;
int val;
int motionLevel;
int volumeLevel;
int RFIDid;


//NFC
#include <SPI.h>
#include "PN532_SPI.h"
#include "PN532.h"
#include "NfcAdapter.h"
 
PN532_SPI interface(SPI, 10); // create a PN532 SPI interface with the SPI CS terminal located at digital pin 10
NfcAdapter nfc = NfcAdapter(interface); // create an NFC adapter object

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

  getSoundInput();

  checkMotion();

  checkNFC();
  delay(1000);
}
