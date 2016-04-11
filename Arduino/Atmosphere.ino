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
  volumeAtmosphere = map(volumeAverage, 30, 50, 0, 100);

  if(volumeAtmosphere > 40 ){
    //changeColour(endColour, red, 35);
    if(RFIDid == 0){
    pulse(red, orange, map(volumeAtmosphere, 46, 100, 10, 3), 1);
    }
    else if(RFIDid == 12){
    pulse(red, orange, map(volumeAtmosphere, 46, 100, 10, 3), 1);
    }
    else if(RFIDid == 2){
    pulse(red, orange, map(volumeAtmosphere, 46, 100, 10, 3), 1);
    }
  }
  else if (volumeAtmosphere > 40 ) {
    //changeColour(endColour, blue, 35);
    if(RFIDid == 0){
    pulse(blue, green, 60, 2);
    }
    else if(RFIDid == 12){
    pulse(blue, green, 60, 2);
    }
    else if(RFIDid == 2){
    pulse(blue, purple, 60, 2);
    }
  }
  
  sendSerial(motionAtmosphere);
  sendSerial(volumeAtmosphere);
  


}
  
