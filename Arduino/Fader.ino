void changeColour(int color1[3], int color2[3], int _timeToChange){
  if(!changingColour){
  changingColour = true;
  changeTimer = 0;
  timeToChange = _timeToChange;
  startColour[0] = color1[0];
  startColour[1] = color1[1];
  startColour[2] = color1[2];
  endColour[0] = color2[0];
  endColour[1] = color2[1];
  endColour[2] = color2[2];
  }
}

void updateColour(){
  if(changingColour && changeTimer < timeToChange){
    lightColour[0] = map(changeTimer, 0, timeToChange, startColour[0], endColour[0]);
    lightColour[1] = map(changeTimer, 0, timeToChange, startColour[1], endColour[1]);
    lightColour[2] = map(changeTimer, 0, timeToChange, startColour[2], endColour[2]);
    changeTimer++;
    
  }
  else {
    changingColour = false;
    changeTimer = 0;
  }
}

