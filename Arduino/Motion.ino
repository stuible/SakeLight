void checkMotion(){
  
  //MOTION
  val = digitalRead(pirPin); //read state of the PIR
  
  if (val == HIGH) { //if the value read is high, there was no motion
    if (motionLevel > 0) {
      motionLevel -= 1;
    }
    Serial.print("&");
    Serial.print(motionLevel);
    Serial.print("&");
    
  }
  else if (val == LOW) { //if the value read was low, there was motion
    motionLevel += 1;
    Serial.print("&");
    Serial.print(motionLevel);
    Serial.print("&");
  }
}

