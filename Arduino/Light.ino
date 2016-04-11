void updateLight(){
  //map volume to RGB Values
  double ledBrightnessR = map(volumeAtmosphere, 10, 100, 0, 255);
  double ledBrightnessB = map(peakToPeak, 20, 400, 100, 0);
  double ledOn = map(peakToPeak, 0, 450, 0, NUMPIXELS);


//  //run through and set all neopixel LEDs
//  for(int i=0;i<NUMPIXELS;i++){
//    double RedLedAmount = map(i, 0, NUMPIXELS, 0, 150);
//
//   // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
//   if (i <= ledOn){
//   pixels.setPixelColor(i, pixels.Color(lightColour[0],lightColour[1], lightColour[2])); //set LED colour
//
//   pixels.show(); //This sends the updated pixel color to the hardware.
//   }
//   else {
//     pixels.setPixelColor(i, 0,0,0); // turn LED off
//   }

  //run through and set all neopixel LEDs
  for(int i=0;i<NUMPIXELS;i++){
    double RedLedAmount = map(i, 0, NUMPIXELS, 0, 150);

   // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
   pixels.setPixelColor(i, pixels.Color(lightColour[0],lightColour[1], lightColour[2])); //set LED colour

   pixels.show(); //This sends the updated pixel color to the hardware.
   
  }
}
