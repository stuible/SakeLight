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
  volumeAtmosphere = map(volumeAverage, 30, 80, 0, 100);

  if(volumeAtmosphere > 50){
    changeColour(endColour, red, 25);
  }
  else {
    changeColour(endColour, blue, 25);
  }
  
  sendSerial(motionAtmosphere);
  sendSerial(volumeAtmosphere);
  


}
  
