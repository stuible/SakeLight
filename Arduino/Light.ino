void updateLight(){
   double ledBrightnessR = map(peakToPeak, 20, 700, 0, 150);
   double ledBrightnessB = map(peakToPeak, 20, 400, 100, 0);
   double ledOn = map(peakToPeak, 20, 400, 0, NUMPIXELS);

   for(int i=0;i<NUMPIXELS;i++){
     double RedLedAmount = map(i, 0, NUMPIXELS, 0, 150);

    // pixels.Color takes RGB values, from 0,0,0 up to 255,255,255
    if (i <= ledOn){
    pixels.setPixelColor(i, pixels.Color(RedLedAmount,0,50)); // Moderately bright green color.

    pixels.show(); // This sends the updated pixel color to the hardware.
    }
    else {
      pixels.setPixelColor(i, 0,0,0);
    }

  }
}

