//collect sensor information from Arduino
void setSerialValues(){
  while (myPort.available() > 0) {
    String myString = myPort.readStringUntil(10);

    if(myString != null){
      myString = trim(myString);

      // split the string at the tabs and convert the sections into integers:
      int[] mysensors = int(splitTokens(myString, "&"));

      try{
        motionLevel = mysensors[0];
        volumeLevel = mysensors[1];
        RFIDid = mysensors[2];
        serialRGB[0] = mysensors[3];
        serialRGB[1] = mysensors[4];
        serialRGB[2] = mysensors[5];
        serialRGB[3] = mysensors[6];
        serialRGB[4] = mysensors[7];
        serialRGB[5] = mysensors[8];
        
        //println("Motion level: " + motionLevel);
        //println("Volume level: " + volumeLevel);
        //println("NFC ID: " + RFIDid);
      } 
      catch(Exception e){
        println("Sensors Unavailable");
      }
    }
  }
}