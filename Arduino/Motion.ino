void checkMotion(){
  val = digitalRead(pirPin2); //read state of the PIR

  //if(atmosphereCounter < averagesLength){
    if (val == HIGH) { //if the value read is high, there was no motion
      if (motionLevel > 0) {
        motionLevel -= 5;
      } 
    } else if (val == LOW) { //if the value read was low, there was motion
      motionLevel += 1;
    }
  //} else {
    //motionLevel = 0;
  //}
  //sendSerial(motionLevel);
  val = digitalRead(pirPin2); //read state of the PIR
//
//  if(atmosphereCounter < averagesLength){
  if (val == HIGH) { //if the value read is high, there was no motion
    if (motionLevel > 0) {
      motionLevel -= 5;
    }
    
  }
  else if (val == LOW) { //if the value read was low, there was motion
    motionLevel += 1;
  }
//  }
//  else {
//    motionLevel = 0;
//  }

  sendSerial(constrain(map(motionLevel, 0, 2000, 0, 350), 0, 350));
}

