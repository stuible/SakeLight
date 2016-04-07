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


void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
  nfc.begin(); // begin NFC communication
  motionLevel = 0;
  volumeLevel = 50;
  RFIDid = 0;
}

void loop() {

  //MOTION
  val = digitalRead(pirPin); //read state of the PIR
  
  if (val == HIGH) { //if the value read is high, there was no motion
    if (motionLevel > 0) {
      motionLevel -= 1;
    }
    Serial.print("&");
    Serial.print(motionLevel);
    Serial.print("&");
    
  }
  else if (val == LOW) { //if the value read was low, there was motion
    motionLevel += 1;
    Serial.print("&");
    Serial.print(motionLevel);
    Serial.print("&");
  }

  

  //VOLUME
  Serial.print(volumeLevel);
  Serial.print("&");


  //NFC
  if (nfc.tagPresent()) { // Do an NFC scan to see if an NFC tag is present
      NfcTag tag = nfc.read(); // read the NFC tag
      if(tag.hasNdefMessage()) {
        NdefMessage message = tag.getNdefMessage();
        for(int i=0;i<message.getRecordCount();i++)
        {
          NdefRecord record = message.getRecord(i);
          int payloadLength = record.getPayloadLength();
          byte payload[payloadLength];
          record.getPayload(payload);
          RFIDid = (payload,payloadLength);
        }
      }
  } else {
    RFIDid = 0;
  }
  Serial.print(RFIDid);
  Serial.print("&");
  
  Serial.println();
  delay(1000);
}
