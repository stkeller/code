void barGraph(int posX, int stationNumber, int minutes, int listeners, ArrayList<String> ageGroups,
              boolean genderMale_state, boolean genderFemale_state, float max_listeners, float max_minutes)
{

float posY = 350;                         // position of all elements on Y axis
float maxHeight = -275;                   // maximum bar graphs height
  int sizeX = 30;                         // bar graphs X size
  int distance = sizeX + (sizeX/1);       // distance between listeners and minutes bar graphs 
  int barGap = 0;                         // a gap between age breakdown bars and the main bar (default = 0 = no gap (sigh..))
  int gridMode = 0;                       // changes how reference parallel lines are displyed. 0 = lines drawn for each bar graph group. 1 = lines drawn across the entire screen
  int mfLine = 25;                        // height of male/female line and letters
  
  int colorRed = 35;                      //  \
  int colorGreen = 20;                    //   - bar graph colour RGB multipliers
  int colorBlue = 22;                     //  /
  int colorVar = 0;                       // color variation between minutes and listeners age breakdowns
  int colorMinutes = 200;                 // grey value for minutes bar graph
  int colorListeners = 100;               // grey value for listeners bar graph
  int[] outlineMinutes = {235, 170, 0};   // \
  int[] outlineListeners = {255, 80, 0};  //  [0] = R, [1] = G, [2] = B. RGB values for bar minutes and listeners outlines

float newPosY = 0;                        // variable declaration. newPosY is calculated for each age breakdown new Y position 
  
float mapped_listeners;
float mapped_minutes;
  
float ages_listeners;
float ages_minutes;

float male_listeners;
float male_minutes;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Translate bar graph position and crop reference lines when only one visualization mode is selected
  int cropRefLineX = 0;
  int translateBarGraphPosX = 0;
  if(listeners == 1){
    cropRefLineX = -25;
    translateBarGraphPosX = -27;
  }
  if(minutes == 1){
    cropRefLineX = -25;
    translateBarGraphPosX = -32;
  }
  if(listeners == 1 && minutes == 1){
    cropRefLineX = 0;
    translateBarGraphPosX = 0;
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Images Array (store all station logos and icons located on 'data' folder)
  PImage[] logos = new PImage[9];
  for(int i = 0; i < logos.length; i++){
    logos[i] = loadImage(i + ".png");
  }
  
  //Display logo
  if(listeners == 1 || minutes == 1){
    image(logos[stationNumber], (posX - 37), (posY + 60) );
  }    
    
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Reference Grid (background parallel lines)
  stroke(140);
  strokeWeight(0.4);
  int refLineDist = 32;
  if(listeners == 1 || minutes == 1){
    if(gridMode == 0){
      for(int i = 0; i < 10; i++){
        line( (posX - 85 - cropRefLineX), posY - (i * refLineDist),
              (posX + 50 + cropRefLineX), posY - (i * refLineDist));
      }
    }
    else if(gridMode > 0 && stationCount == 1){
      for(int i = 0; i < 10; i++){
       line(75, posY-(i*refLineDist), width-75, posY-(i*refLineDist));
      }
    }
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LISTENERS////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  strokeWeight(1.2);
  textAlign(CENTER);
  
  // Listeners bar graph
  if(listeners == 1){
    image(logos[7], (posX - 57 - translateBarGraphPosX), posY + 3); // listeners Icon
        
    mapped_listeners = map( listenersTable.getFloat(stationNumber, 1), 0, max_listeners, 0, maxHeight );
    
    //draw listener bar when there's no gender breakdown
    if(!(genderMale_state || genderFemale_state)){
      rectMode(CORNER);
      fill(colorListeners);
      stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
      rect( (posX - distance - translateBarGraphPosX), posY,
             sizeX, mapped_listeners);
        
      // Label - Display listeners values
      if(ageGroups.size() == 0){  
        fill(0);    
        text( int(listenersTable.getFloat(stationNumber, 1)),
             (posX - distance + 15  - translateBarGraphPosX ), posY + mapped_listeners - 5);
      }
    }
 
    //gender breakdown   
    
    if (genderMale_state || genderFemale_state){
      male_listeners = listenersTable.getFloat(stationNumber, 12);
  
      //translate rectangles
      float barTrim_listeners = 0;
      for(int i = 0; i < ageGroups.size(); i++){
        barTrim_listeners = barTrim_listeners -
                           ( listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_listeners );
      }
      rectMode(CORNER);
      fill(colorListeners);
      stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
      rect( (posX - translateBarGraphPosX - distance - male_listeners * sizeX + sizeX/2) , (posY - barTrim_listeners),
           sizeX, mapped_listeners + barTrim_listeners);
           
      //Label - m and f
      textSize(12);
      fill(0);
      text('M', (posX - distance+6 - translateBarGraphPosX), (posY + maxHeight - mfLine) );
      text('F', (posX - distance+28 - translateBarGraphPosX), (posY + maxHeight - mfLine) );
      //Label - Male listeners values
      if(genderMale_state && ageGroups.size() == 0){
        pushMatrix();
        textSize(10);
        translate( (posX - translateBarGraphPosX - distance - male_listeners * sizeX + sizeX/2 - 6), (posY + mapped_listeners + 35) );
        rotate(-PI/2);
        text(int(male_listeners * listenersTable.getFloat(stationNumber, 1)) + "  /  " + int(male_listeners * 100) + "%", 0,0);
        popMatrix();
      }
      //Label - Female listeners values
      if(genderFemale_state && ageGroups.size() == 0){
        pushMatrix();
        textSize(10);
        translate( (posX - translateBarGraphPosX - distance - male_listeners * sizeX + sizeX/2 + 38), (posY + mapped_listeners + 35) );
        rotate(-PI/2);
        text(int((1 - male_listeners) * listenersTable.getFloat(stationNumber, 1)) + "  /  " + int((1 - male_listeners) * 100) + "%", 0,0);
        popMatrix();
      }
      
      //draw line at halfway point
      stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
      line( (posX - translateBarGraphPosX - distance+sizeX/2), posY,
            (posX - translateBarGraphPosX - distance+sizeX/2),(posY + maxHeight - (mfLine + 10)) );
    }
  
    // Age Breakdown
    if(ageGroups.size() > 0){ 
      for(int i = 0; i < ageGroups.size(); i++){
        // Calculate bars Y position
        ages_listeners = listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_listeners;
        
        // Draw age breakdown
          
        //with no gender breakdown
        if (!(genderMale_state || genderFemale_state)){
          rectMode(CORNER);
          stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
          fill(240-(int(ageGroups.get(i)) * colorRed),
               240-(int(ageGroups.get(i))*colorGreen),
               240-(int(ageGroups.get(i))*colorBlue));
          rect( (posX - distance - translateBarGraphPosX), (posY - newPosY),
                (sizeX - barGap), ages_listeners);  
              
          newPosY = newPosY - ages_listeners;
       
          // Label - Display first age breakdown value
          if(ageGroups.size() == 1){  
            textSize(10);
            fill(255);
            int ageVal_ListenersLabel = int(listenersTable.getFloat(stationNumber, 1) *
                                            listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2));
            text(ageVal_ListenersLabel, (posX - distance + 16 - translateBarGraphPosX), (posY - newPosY - 8) );
          }
        }
           
        //If gender is also brokendown
        if (genderMale_state || genderFemale_state){
          male_listeners = listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 11);
            
          //translate rectangles
          rectMode(CORNER);
          stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
          fill(240-(int(ageGroups.get(i)) * colorRed),
               240-(int(ageGroups.get(i))*colorGreen),
               240-(int(ageGroups.get(i))*colorBlue));
          rect( (posX - translateBarGraphPosX - distance - male_listeners*sizeX + sizeX/2), (posY - newPosY),
                 sizeX, ages_listeners);
            
          newPosY = newPosY - ages_listeners;
          
          //draw line at halfway point
          strokeWeight(1);
          stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
          line( (posX - translateBarGraphPosX - distance + sizeX/2), posY,
                (posX - translateBarGraphPosX - distance + sizeX/2),(posY + maxHeight - (mfLine+10)) );
        }          
      }
    }
  }
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Minutes//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Minutes Bar Graph
  strokeWeight(1.2);
  if(minutes == 1){
    image(logos[8], (posX + 3 + translateBarGraphPosX), posY + 3); // listeners Icon
    
    mapped_minutes = map( minutesTable.getInt(stationNumber,1), 0, max_minutes, 0, maxHeight );
  
    //Draw minute bars for no gender and no age breakdown
    if (!(genderMale_state || genderFemale_state)){ 
      rectMode(CORNER);
      fill(colorMinutes);
      stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
      rect( (posX + translateBarGraphPosX), posY, sizeX, mapped_minutes);
      
      // Label - Display Minutes values
      if(ageGroups.size() == 0){
        textSize(10);
        fill(0);    
        text( minutesTable.getInt(stationNumber, 1), (posX + 17 + translateBarGraphPosX), (posY + mapped_minutes - 5) );
      }
    }
  
    //gender breakdown   
  
    if (genderMale_state || genderFemale_state){
      male_minutes = minutesTable.getFloat(stationNumber, 12);

      //translate rectangles
      float barTrim_minutes = 0;
      for(int i = 0; i < ageGroups.size(); i++){
        barTrim_minutes = barTrim_minutes -
                          ( minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_minutes );
      }
      rectMode(CORNER);
      fill(colorMinutes);
      stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
      rect( (posX + translateBarGraphPosX - male_minutes * sizeX + sizeX/2), (posY - barTrim_minutes),
           sizeX, (mapped_minutes + barTrim_minutes) );
         
      //Label - m and f
      textSize(12);
      fill(0);
      text('M', (posX + 6 + translateBarGraphPosX), (posY + maxHeight - mfLine) );
      text('F', (posX + 28 + translateBarGraphPosX), (posY + maxHeight - mfLine) );
      //Label - Male listeners values
      if(( genderMale_state) && ageGroups.size() == 0){
        pushMatrix();
        textSize(10);
        translate( (posX + translateBarGraphPosX - male_minutes*sizeX + sizeX/2 - 6) , (posY + mapped_minutes + 35) );
        rotate(-PI/2);
        text(int(male_minutes * minutesTable.getFloat(stationNumber, 1)) + "  /  " + int(male_minutes * 100) + "%", 0,0 );
        popMatrix();
      }
      //Label - Female listeners values
      if( (genderFemale_state) && ageGroups.size() == 0){
        pushMatrix();
        textSize(10);
        translate( (posX + translateBarGraphPosX - male_minutes*sizeX + sizeX/2 + 38), (posY + mapped_minutes + 35) );
        rotate(-PI/2);
        text(int((1 - male_minutes) * minutesTable.getFloat(stationNumber, 1)) + "  /  " + int((1 - male_minutes) * 100) + "%", 0,0 );
        popMatrix();
      }
      
      // draw line at halfway point
      stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
      line( (posX + translateBarGraphPosX + sizeX/2), posY,
            (posX + translateBarGraphPosX + sizeX/2), (posY + maxHeight - (mfLine+10)) );     
    }

    // Age Breakdown
    if(ageGroups.size() > 0){
      
      newPosY=0;
         
      for(int i = 0; i < ageGroups.size(); i++){
        // Calculate bars Y position
        ages_minutes = minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_minutes;
            
        // Draw age breakdown
        
        //with no gender breakdown
        if (!(genderMale_state || genderFemale_state)){
          rectMode(CORNER);
          stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
          fill(240-(int(ageGroups.get(i)) * colorRed + colorVar),
               240-(int(ageGroups.get(i))*colorGreen  + colorVar), 
               240-(int(ageGroups.get(i))*colorBlue + colorVar));
          rect( (posX + translateBarGraphPosX), (posY - newPosY),
                (sizeX - barGap), ages_minutes);    
             
          newPosY = newPosY - ages_minutes;
          
          // Label - Display first age breakdown value
          if(ageGroups.size() == 1){  
            textSize(10);
            fill(0);
            int ageVal_MinutesLabel = int(minutesTable.getFloat(stationNumber, 1) *
                                          minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2));
            text(ageVal_MinutesLabel, (posX + 16 + translateBarGraphPosX), (posY - newPosY - 8) );
          }
        }
         
        //If gender is also brokendown
        if (genderMale_state || genderFemale_state){  
            male_minutes = minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 11);

           //translate rectangles
           rectMode(CORNER);
           stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
           fill(240-(int(ageGroups.get(i)) * colorRed + colorVar),
                240-(int(ageGroups.get(i))*colorGreen  + colorVar),
                240-(int(ageGroups.get(i))*colorBlue + colorVar));
           rect( (posX + translateBarGraphPosX - male_minutes*sizeX + sizeX/2), (posY - newPosY),
                  sizeX, ages_minutes);
        
           newPosY = newPosY - ages_minutes;
           
           // draw line at halfway point
           strokeWeight(1);
           stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
           line( (posX + translateBarGraphPosX + sizeX/2), posY,
                 (posX + translateBarGraphPosX + sizeX/2), (posY + maxHeight - (mfLine+10)) );
        }             
      }
    } 
  }
}
