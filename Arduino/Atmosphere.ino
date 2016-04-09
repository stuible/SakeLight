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
  volumeAtmosphere = map(volumeAverage, 0, 140, 0, 100);
  sendSerial(motionAtmosphere);
  sendSerial(volumeAtmosphere);
  


}
  
