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