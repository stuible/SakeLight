void setSerialValues(){
  while (myPort.available() > 0) {
    String myString = myPort.readStringUntil(10);

    if(myString != null){
      myString = trim(myString);

      // split the string at the tabs and convert the sections into integers:
      int[] mysensors = int(splitTokens(myString, "&"));

      try{
        motionLevel1 = mysensors[0];
        motionLevel2 = mysensors[1];
        volumeLevel = mysensors[2];
        RFIDid = mysensors[3];
        //motionAtmosphere = mysensors[4];
        //volumeAtmosphere = mysensors[5];
        
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