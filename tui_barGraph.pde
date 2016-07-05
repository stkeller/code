// Reference lines variables 
  int gridMode = 1;                      // changes how reference parallel lines are displyed. 0 = lines drawn for each bar graph group. 1 = lines drawn across the entire screen
  int[] refLineColor = {180,180,180};    //RGB values for reference line colour
float refLineWeight = 0.8;
// global variable used on both .pde files
float posY = 880;
float maxHeight = -500;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Bar Graph Function///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
void barGraph(int posX, int stationNumber, int minutes, int listeners, ArrayList<String> ageGroups,
              boolean genderMale_state, boolean genderFemale_state, float max_listeners, float max_minutes, int gridMode)
{
  int sizeX = 40;                        // bar graphs X size
float distance = sizeX + (sizeX/1);    // distance between listeners and minutes bar graphs 
  int barGap = 0;                        // a gap between age breakdown bars and the main bar (default = 0 = no gap (sigh..))
  int mfLine = 25;                       // height of male/female line and letters
  int percentageHeight = -7;             // adjusts height of male/female percentage
  int percentageMalePos = 3;
  int percentageFemalePos = 29;
  
  int colorRed = 35;                         // \
  int colorGreen = 20;                       //  - bar graph colour RGB multipliers
  int colorBlue = 22;                        // /
  int colorVar = 0;                          // color variation between minutes and listeners age breakdowns
  int colorMinutes = 200;                    // grey value for minutes bar graph
  int colorListeners = 100;                  // grey value for listeners bar graph
float outlineWeigth = 0;
  int[] outlineMinutes = {200, 200, 200};    // \   [0] = R, [1] = G, [2] = B. RGB values for bar minutes and listeners outlines 
  int[] outlineListeners = {100, 100, 100};  //   -  Non-grey values: Minutes = {235, 170, 0}; Listeners = {255, 80, 0};
  int[] lineDivMinutes = {0,0,0};            // \
  int[] lineDivListeners = {0,0,0};          //  - RGB values for Male/Female line
float expValue = 2.05;                       // Exponential value for color algorithm

  int[][] ageRGB = {
                     {20,  65,  175},
                     {55,  80,  220},
                     {78,  152, 198},
                     {130, 205, 184},
                     {190, 226, 204},
                     {255, 242, 218},
                     {255, 221, 136},
                     {244, 151, 89},
                     {232, 99,  73},
                     {211, 35,  39}
                   };

float newPosY = 0;                           // variable declaration. newPosY is calculated for each age breakdown new Y position 
float newPosY_male = 0;                      // ""
float newPosY_female = 0;                    // ""

float gender_shift = sizeX/2 - 6;            // distance between male and female bar graphs
  
float mapped_listeners;
float mapped_male_listeners;
float mapped_female_listeners;

float mapped_minutes;
float mapped_male_minutes;
float mapped_female_minutes;
  
float ages_listeners;
float ages_male_listeners;
float ages_female_listeners;

float ages_minutes;
float ages_male_minutes;
float ages_female_minutes;

float male_listeners;
float female_listeners;

float male_minutes;
float female_minutes;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Translate bar graph position and crop reference for the selected visualization options
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  int translateBarGraphPosX = 0;
  int translateIcons_Gender = 0;
  
  int sizeXLarge = 40;
  int sizeXSmall = 25;
  //Listener Pos. Modifiers
  if(listeners == 1 && !(genderMale_state && genderFemale_state)){
    sizeX = sizeXLarge;
    translateBarGraphPosX = -42;
    translateIcons_Gender = 0;
  }
  if(listeners == 1 && !(genderMale_state) && (genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = -35;
    translateIcons_Gender = -7;
  }
  if(listeners == 1 && (genderMale_state) && !(genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = -62;
    translateIcons_Gender = 20;
  }
  if(listeners == 1 && (genderMale_state) && (genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = -49;
    translateIcons_Gender = 7;
  }
  
  //Minutes Pos. Modifiers
  if(minutes == 1 && !(genderMale_state && genderFemale_state)){
    sizeX = sizeXLarge;
    translateBarGraphPosX = -40;
    translateIcons_Gender = 80;
  }
  if(minutes == 1 && !(genderMale_state) && (genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = 50;
    translateIcons_Gender = -10;
  }
  if(minutes == 1 && (genderMale_state) && !(genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = 20;
    translateIcons_Gender = 20;
  }
  if(minutes == 1 && (genderMale_state) && (genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = 35;
    translateIcons_Gender = 5;
  }
  
  //Listeners and Minutes Pos. Modifiers
  if(listeners == 1 && minutes == 1 && !(genderMale_state && genderFemale_state)){
    sizeX = sizeXLarge;
    translateBarGraphPosX = 0;
    translateIcons_Gender = 0;
  }
  if(listeners == 1 && minutes == 1 && !(genderMale_state) && (genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = 7;
    translateIcons_Gender = -7;
  }
  if(listeners == 1 && minutes == 1 && (genderMale_state) && !(genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = -20;
    translateIcons_Gender = 20;
  }
  if(listeners == 1 && minutes == 1 && (genderMale_state) && (genderFemale_state)){
    sizeX = sizeXSmall;
    translateBarGraphPosX = -7;
    translateIcons_Gender = 7;
  }

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Images Array (store all station logos and icons located on 'data' folder)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  PImage[] logos = new PImage[11];
  for(int i = 0; i < logos.length; i++){
    logos[i] = loadImage(i + ".png");
  }
  
  //Display logo
  if(listeners == 1 || minutes == 1){
    image(logos[stationNumber], (posX - 40), (posY + 60) );
  }
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LISTENERS////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  strokeWeight(outlineWeigth);
  textFont(numberFont);
  textAlign(CENTER);
  
  // Listeners bar graph
  if(listeners == 1){
    image(logos[7], (posX - 73 - translateBarGraphPosX - translateIcons_Gender), posY + 3); // listeners Icon
    
    mapped_listeners = map( listenersTable.getFloat(stationNumber, 1), 0, max_listeners, 0, maxHeight );
    
    //draw listener bar when there's no gender breakdown
    if(!(genderMale_state || genderFemale_state)){
      rectMode(CORNER);
      
      //no gender breakdown and no age breakdown
      fill(colorListeners);
      stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
      rect( (posX - distance - translateBarGraphPosX), posY,
             sizeX, mapped_listeners);
        
      // Label - Display listeners values
      if(ageGroups.size() == 0){  
        fill(0);    
        text( int(listenersTable.getFloat(stationNumber, 1)),
             (posX - distance + 20 - translateBarGraphPosX ), posY + mapped_listeners - 5);
      }
      
    // Age Breakdown with no gender breakdown
    if(ageGroups.size() > 0){ 
      for(int i = 0; i < ageGroups.size(); i++){
        // Calculate bars Y position
        ages_listeners = listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_listeners;
        
        rectMode(CORNER);
        stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
        fill(ageRGB[int(ageGroups.get(i))][0],
             ageRGB[int(ageGroups.get(i))][1],
             ageRGB[int(ageGroups.get(i))][2]);
        rect( (posX - distance - translateBarGraphPosX), (posY - newPosY),
              (sizeX - barGap), ages_listeners);  
              
        newPosY = newPosY - ages_listeners;
       
        // Label - Display first age breakdown value
        if(ageGroups.size() == 1){  
          textSize(10);
          fill(255);
          int ageVal_ListenersLabel = int(listenersTable.getFloat(stationNumber, 1) *
                                          listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2));
          //text(ageVal_ListenersLabel, (posX - distance + 19 - translateBarGraphPosX), (posY - newPosY - 8) );
        }
      }
    }
  }

//////gender breakdown  

    if (genderMale_state || genderFemale_state){
      male_listeners = listenersTable.getFloat(stationNumber, 12)*listenersTable.getFloat(stationNumber,1);
      female_listeners=  listenersTable.getFloat(stationNumber,1)-male_listeners;
      
      mapped_male_listeners = map( male_listeners, 0, max_listeners, 0, maxHeight );
      mapped_female_listeners = map (female_listeners, 0, max_listeners, 0, maxHeight );
      
      //with no age breakdown
      if (genderMale_state){
        //male bar
        fill(colorListeners);
        stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
        rect( (posX - distance - translateBarGraphPosX-gender_shift), posY,
               sizeX, mapped_male_listeners);  
        image(logos[10], (posX - distance - 11 - translateBarGraphPosX), (posY + mapped_male_listeners - 25)); // male Icon        
        //Label
        if(!genderFemale_state && ageGroups.size() == 0){
          textSize(12);
          fill(0);
          text(int(male_listeners), (posX - distance - translateBarGraphPosX), (posY + mapped_male_listeners - 30) );
        }
      }
       
      if (genderFemale_state){
        //female bar       
        fill(colorListeners);
        stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);     
        rect( (posX - distance - translateBarGraphPosX + gender_shift), posY,
               sizeX, mapped_female_listeners);
        image(logos[9], (posX - distance + 17 - translateBarGraphPosX), (posY + mapped_female_listeners - 25)); // female Icon
        //Label
        if(!genderMale_state && ageGroups.size() == 0){
          textSize(12);
          fill(0);
          text(int(female_listeners), (posX - distance + 28 - translateBarGraphPosX), (posY + mapped_female_listeners - 30) );
        }
      }
       
      //with age breakdown
      if(ageGroups.size() > 0){ 
          
        for(int i = 0; i < ageGroups.size(); i++){
          // Calculate bars Y position
          ages_male_listeners = listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 13 ) * listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_listeners;
          ages_female_listeners = (1-listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 13 )) * listenersTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_listeners;
          
          //draw male bars 
          if(genderMale_state){
            rectMode(CORNER);
            stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
            fill(ageRGB[int(ageGroups.get(i))][0],
                 ageRGB[int(ageGroups.get(i))][1],
                 ageRGB[int(ageGroups.get(i))][2]);
            rect( (posX - distance - translateBarGraphPosX-gender_shift), (posY - newPosY_male),
                  (sizeX - barGap), ages_male_listeners);  
                
            newPosY_male = newPosY_male - ages_male_listeners;      
          }
       
          //draw female bars
          if(genderFemale_state){
            rectMode(CORNER);
            stroke(outlineListeners[0], outlineListeners[1], outlineListeners[2]);
            fill(ageRGB[int(ageGroups.get(i))][0],
                 ageRGB[int(ageGroups.get(i))][1],
                 ageRGB[int(ageGroups.get(i))][2]);
            rect( (posX - distance - translateBarGraphPosX+gender_shift), (posY - newPosY_female),
                  (sizeX - barGap), ages_female_listeners);  
                
            newPosY_female = newPosY_female - ages_female_listeners;       
          }
        }
//close if ageGroups  
      }
//close if gender
    }
// close if listeners
  }
  
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////Minutes//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  textFont(numberFont);
  // Minutes Bar Graph
  strokeWeight(outlineWeigth);
  if(minutes == 1){
    image(logos[8], (posX + 6 - translateBarGraphPosX - translateIcons_Gender), posY + 3); // listeners Icon
    
    mapped_minutes = map( minutesTable.getInt(stationNumber,1), 0, max_minutes, 0, maxHeight );
  
    //Draw minute bars for no gender and no age breakdown
    if (!(genderMale_state || genderFemale_state)){ 
      rectMode(CORNER);
      fill(colorMinutes);
      stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
      rect( (posX + translateBarGraphPosX), posY, sizeX, mapped_minutes);
      
      // Label - Display Minutes values
      if(ageGroups.size() == 0){
        fill(0);    
        text( minutesTable.getInt(stationNumber, 1), (posX + 17 + translateBarGraphPosX), (posY + mapped_minutes - 5) );
      }
     
    //age breakdown with no gender breakdown  
     
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
          fill(ageRGB[int(ageGroups.get(i))][0],
               ageRGB[int(ageGroups.get(i))][1],
               ageRGB[int(ageGroups.get(i))][2]);
          rect( (posX + translateBarGraphPosX), (posY - newPosY),
                (sizeX - barGap), ages_minutes);    
             
          newPosY = newPosY - ages_minutes;
          
          // Label - Display first age breakdown value
          if(ageGroups.size() == 1){  
            textSize(10);
            fill(0);
            int ageVal_MinutesLabel = int(minutesTable.getFloat(stationNumber, 1) *
                                          minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2));
            //text(ageVal_MinutesLabel, (posX + 19 + translateBarGraphPosX), (posY - newPosY - 8) );
          }
        }
      }
    }
  }
    
//////gender breakdown   
  
    //gender breakdown with no age breakdown
    if (genderMale_state || genderFemale_state){
      male_minutes = minutesTable.getFloat(stationNumber, 12)*minutesTable.getFloat(stationNumber,1);
      female_minutes=  minutesTable.getFloat(stationNumber,1)-male_minutes;
  
      mapped_male_minutes = map( male_minutes, 0, max_minutes, 0, maxHeight );
      mapped_female_minutes = map (female_minutes, 0, max_minutes, 0, maxHeight );
  
      //with no age breakdown
     
      if (genderMale_state){
        //male
        fill(colorMinutes);
        stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
        rect( (posX - translateBarGraphPosX-gender_shift), posY,
               sizeX, mapped_male_minutes);
        tint(255,100); // half opacity to match bar graph color
        image(logos[10], (posX - 11 - translateBarGraphPosX), (posY + mapped_male_minutes - 25)); // male Icon        
        //Label
        if(!genderFemale_state && ageGroups.size() == 0){
          textSize(12);
          fill(0);
          text(int(male_minutes), (posX - translateBarGraphPosX), (posY + mapped_male_minutes - 30) );
        }
      }
     
      if (genderFemale_state){
        //female       
        fill(colorMinutes);
        stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);     
        rect( (posX - translateBarGraphPosX + gender_shift), posY,
               sizeX, mapped_female_minutes);
        tint(255,100); // half opacity to match bar graph color
        image(logos[9], (posX + 17 - translateBarGraphPosX), (posY + mapped_female_minutes - 25)); // female Icon
        //Label
        if(!genderMale_state && ageGroups.size() == 0){
          textSize(12);
          fill(0);
          text(int(female_minutes), (posX + 28 - translateBarGraphPosX), (posY + mapped_female_minutes -30) );
        }
      }
      tint(255,255); // restore default image opacity value
     
      //with age breakdown
      if(ageGroups.size() > 0){ 
        
        newPosY_male = 0;
        newPosY_female= 0;
        
        for(int i = 0; i < ageGroups.size(); i++){ 
          // Calculate bars Y position
          ages_male_minutes = minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 13 ) * minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_minutes;
          ages_female_minutes = (1-minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 13 )) * minutesTable.getFloat(stationNumber, int(ageGroups.get(i)) + 2 ) * mapped_minutes;
          
          //draw male bars
          if(genderMale_state){
            rectMode(CORNER);
            stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
            fill(ageRGB[int(ageGroups.get(i))][0],
                 ageRGB[int(ageGroups.get(i))][1],
                 ageRGB[int(ageGroups.get(i))][2]);
            rect( (posX - translateBarGraphPosX-gender_shift), (posY - newPosY_male),
                  (sizeX - barGap), ages_male_minutes);  
                  
            newPosY_male = newPosY_male - ages_male_minutes;      
          }
          
          //draw female bars
          if(genderFemale_state){
            rectMode(CORNER);
            stroke(outlineMinutes[0], outlineMinutes[1], outlineMinutes[2]);
            fill(ageRGB[int(ageGroups.get(i))][0],
                 ageRGB[int(ageGroups.get(i))][1],
                 ageRGB[int(ageGroups.get(i))][2]);
            rect( (posX - translateBarGraphPosX+gender_shift), (posY - newPosY_female),
                  (sizeX - barGap), ages_female_minutes);  
                  
            newPosY_female = newPosY_female - ages_female_minutes;        
          }
        }
//close if ageGroups  
      }
//close if gender  
    }
//close if minutes
  }
//close function
}
