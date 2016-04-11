void checkMotion(){
  val = digitalRead(pirPin1); //read state of the PIR

  if(atmosphereCounter < averagesLength){
    if (val == HIGH) { //if the value read is high, there was no motion
      if (motionLevel > 0) {
        motionLevel -= 1;
      }
      sendSerial(motionLevel); 
    } else if (val == LOW) { //if the value read was low, there was motion
      motionLevel += 1;
      sendSerial(motionLevel);
    }
  } else {
    motionLevel = 0;
  }

  val = digitalRead(pirPin2); //read state of the PIR

  if(atmosphereCounter < averagesLength){
  if (val == HIGH) { //if the value read is high, there was no motion
    if (motionLevel > 0) {
      motionLevel -= 1;
    }
    sendSerial(motionLevel);
    
  }
  else if (val == LOW) { //if the value read was low, there was motion
    motionLevel += 1;
    sendSerial(motionLevel);
  }
  }
  else {
    motionLevel = 0;
  }
}

