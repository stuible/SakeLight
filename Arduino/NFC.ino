void checkNFC(){
  if (nfc.tagPresent(25)) { // Do an NFC scan to see if an NFC tag is present
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

        if(RFIDid >= 0 && RFIDid <= 100){
          RFIDid = RFIDid;
        }
        else {
          RFIDid = 0;
        }
      }
  } 
  else{
    RFIDid = 0;
  }
  sendSerial(RFIDid);
}

