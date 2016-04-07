void startSerial(){
  Serial.print("&");
}

void endSerial(){
  Serial.println();
}

void sendSerial(int x){
  Serial.print(x);
  Serial.print("&");
}

