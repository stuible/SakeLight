void updateAtmosphere(){ 
  if(atmosphereCounter < averagesLength){
    volumeAverages[atmosphereCounter] = volumeLevel;
    motionAverages[atmosphereCounter] = motionLevel;
    atmosphereCounter++;
    //sendSerial(volumeAverage);
    //sendSerial(motionAverage);
  }
  else {
    for(int i = 0; i < averagesLength; i++){
      volumeAverage += volumeAverages[i];
      motionAverage += motionAverages[i];
    } 
    volumeAverage = volumeAverage / averagesLength;
    motionAverage = motionAverage / averagesLength;
    atmosphereCounter = 0;
    //sendSerial(volumeAverage);
    //sendSerial(motionAverage);
  }

  motionAtmosphere = map(motionAverage, 0, 25, 0, 100);
  volumeAtmosphere = constrain(map(volumeAverage, 0, 70, 0, 100), 0, 100);

  if (volumeAtmosphere < 30 ) {
    //changeColour(endColour, blue, 35);
    if(RFIDid == 0){
    pulse(blue, green, 60, 4);
    }
    else if(RFIDid == 12){
    pulse(blue, green, 60, 5);
    }
    else if(RFIDid == 2){
    pulse(blue, purple, 60, 6);
    }
  }
  else if(volumeAtmosphere < 100 ){
    //changeColour(endColour, red, 35);
    if(RFIDid == 0){
    pulse(red, orange, constrain(map(((volumeAtmosphere * 3) + motionAtmosphere) / 4, 25, 60, 10, 3), 3, 10), 1);
    }
    else if(RFIDid == 12){
    pulse(red, orange, constrain(map(((volumeAtmosphere * 3) + motionAtmosphere) / 4, 25, 60, 10, 3), 3, 10), 2);
    }
    else if(RFIDid == 2){
    pulse(pink, orange, constrain(map(((volumeAtmosphere * 3) + motionAtmosphere) / 4, 25, 60, 10, 3), 3, 10), 3);
    }
  }
  
  //sendSerial(motionAtmosphere);
  //sendSerial(volumeAtmosphere);  
  


}
  
