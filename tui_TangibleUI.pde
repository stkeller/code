// Fiducial Markers IDs Reference
/*
0  - Station 1 (680 News)
1  - Station 2 (Newstalk)
2  - Station 3 (Virgin Radio)
3  - Station 4 (Q107)
4  - Station 5 (102.1 The Edge)
5  - Station 6 (CBC R1)
6  - Number of Listeners
7  - Minutes Listened
8  - Male Breakdown
9  - Female Breakdown
10 - Age Breakdown 1
11 - Age Breakdown 2
12 - Age Breakdown 3
13 - Age Breakdown 4
14 - Age Breakdown 5
15 - Age Breakdown 6
16 - Age Breakdown 7
17 - Age Breakdown 8
18 - Age Breakdown 9
19 - Age Breakdown 10
20 - Age Detail (Compare)
*/

// TUIO
import TUIO.*;
TuioProcessing tuioClient;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
// ID Variables
int markerQty = 21;
int markerCounter = 0;
boolean[] markerID = new boolean[markerQty];


// CSV Tables
Table minutesTable;
Table listenersTable;

// Fonts
PFont numberFont;
PFont titleFont;
PFont promptFont;

// visualization state variables declaration
int genderMale_state = 0;
int genderFemale_state = 0;

int ageGroup1_state = 0;
int ageGroup2_state = 0;
int ageGroup3_state = 0;
int ageGroup4_state = 0;
int ageGroup5_state = 0;
int ageGroup6_state = 0;
int ageGroup7_state = 0;
int ageGroup8_state = 0;
int ageGroup9_state = 0;
int ageGroup10_state = 0;

int station1_state = 0;
int station2_state = 0;
int station3_state = 0;
int station4_state = 0;
int station5_state = 0;
int station6_state = 0;

int detail1_state = 0;

int stationCount = 0;

int listeners_state = 0;
int minutes_state = 0;

                                                                                                                      // Marker IDs
int[] stateArray = {station1_state, station2_state, station3_state, station4_state, station5_state, station6_state,   // 0, 1, 2, 3, 4, 5,
                    listeners_state, minutes_state,                                                                   // 6, 7,
                    genderMale_state, genderFemale_state,                                                             // 8, 9,
                    ageGroup1_state, ageGroup2_state, ageGroup3_state, ageGroup4_state, ageGroup5_state,              // 10, 11, 12, 13, 14,
                    ageGroup6_state, ageGroup7_state, ageGroup8_state, ageGroup9_state, ageGroup10_state,             // 15, 16, 17, 18, 19
                    detail1_state};                                                                                   // 20
                      
int[] stationArray = { 0, 0, 0, 0, 0, 0 };
int[] ageArray = { 0, 0, 0, 0, 0,
                   0, 0, 0, 0, 0 };


int[] listener_value = {0, 0, 0, 0, 0, 0};
int[] minute_value = {0, 0, 0, 0, 0, 0};

float[] age_listener_value = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
float[] age_minute_value = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

float max_listener_detail;
float max_minutes_detail;

float max_listeners;
float max_minutes;

ArrayList<String> activeStations = new ArrayList<String> ();


// Arrays to store markers (x,y) position values (markers #10-19)
float[][] markerPosXY =  {
                        // XY arrays    Markers ID
                        {0,0},{0,0}, // #0,  #1  (Stations)
                        {0,0},{0,0}, // #2,  #3  (   "    )
                        {0,0},{0,0}, // #4,  #5  (   "    )
                        {0,0},{0,0}, // #6,  #7  (Listeners, Minutes)
                        {0,0},{0,0}, // #8,  #9  (Male, Female)
                        {0,0},{0,0}, // #10, #11 (Age groups)
                        {0,0},{0,0}, // #12, #13 ( "     "  )
                        {0,0},{0,0}, // #14, #15 ( "     "  )
                        {0,0},{0,0}, // #16, #17 ( "     "  )
                        {0,0},{0,0}, // #18, #19 ( "     "  )
                        {0,0}        // #20      (Detail)
                      };
// array to store distance between detail marker and each age group marker
float distanceArray[] = {0,0,0,0,0,
                         0,0,0,0,0};
// funtction to calculate distance
float distance( float pointA_X, float pointA_Y,
                float pointB_X, float pointB_Y)
{
  if(pointB_X != 0 && pointB_Y != 0)
  {
    return sqrt( pow(pointA_X - pointB_X, 2) +
                 pow(pointA_Y - pointB_Y, 2) );
  }
  else{ return 1;}
}


//---------------------------

public void setup() {
  size(1900, 1000);
  noStroke();
  
  minutesTable = loadTable("minutes.csv");
  listenersTable = loadTable("listeners.csv");
  
  // TUIO Setuo
  // periodic updates
  if (!callback) {
    frameRate(60); //<>//
    loop();
  } else noLoop(); // or callback updates 
  // create an instance of the TuioProcessing client
  tuioClient  = new TuioProcessing(this);
}


void draw()
{
  background(255);
  numberFont = createFont("Arial", 16);
  titleFont = createFont("Georgia", 24);
  promptFont = createFont("Georgia", 48);
    
  // Check and store which age group buttons are currently pressed
  ArrayList<String> activeAges = new ArrayList<String> ();
  for(int i = 0; i < 10; i++){
    if(ageArray[i] == 1){
      activeAges.add(str(i));
  }}
  println("Active Stations = " + activeStations);
  println("Active Age Groups = " + activeAges);
  println(stationCount);
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //Visualization Titles/////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if(stationCount != 0){
    int titleHeight = 50;
    // No gender and age breakdown
    textFont(titleFont);
    fill(0);
    if(stateArray[6] == 1 && stateArray[7] == 0 && activeAges.size() == 0 && stateArray[8] == 0 && stateArray[9] == 0){
      textAlign(CENTER);
      text("Total number of listeners", width/2, titleHeight);
    }
    if(stateArray[6] == 0 && stateArray[7] == 1 && activeAges.size() == 0 && stateArray[8] == 0 && stateArray[9] == 0){
      textAlign(CENTER);
      text("Total minutes listened", width/2, titleHeight);
    }
    if(stateArray[6] == 1 && stateArray[7] == 1 && activeAges.size() == 0 && stateArray[8] == 0 && stateArray[9] == 0){
      textAlign(CENTER);
      text("Total number of listeners and minutes listened", width/2, titleHeight);
    }
    
    // age breakdown
    if(stateArray[6] == 1 && stateArray[7] == 0 && activeAges.size() > 0 && stateArray[8] == 0 && stateArray[9] == 0){
      textAlign(CENTER);
      text("Total number of listeners, broken down by age", width/2, titleHeight);
    }
    if(stateArray[6] == 0 && stateArray[7] == 1 && activeAges.size() > 0 && stateArray[8] == 0 && stateArray[9] == 0){
      textAlign(CENTER);
      text("Total minutes listened, broken down by age", width/2, titleHeight);
    }
    if(stateArray[6] == 1 && stateArray[7] == 1 && activeAges.size() > 0 && stateArray[8] == 0 && stateArray[9] == 0){
      textAlign(CENTER);
      text("Total number of listeners and minutes listened, broken down by age", width/2, titleHeight);
    }
    
    // gender breakdown
    if(stateArray[6] == 1 && stateArray[7] == 0 && activeAges.size() == 0 && (stateArray[8] == 1 || stateArray[9] == 1)){
      textAlign(CENTER);
      text("Total number of listeners, broken down by gender", width/2, titleHeight);
    }
    if(stateArray[6] == 0 && stateArray[7] == 1 && activeAges.size() == 0 && (stateArray[8] == 1 || stateArray[9] == 1)){
      textAlign(CENTER);
      text("Total minutes listened, broken down by gender", width/2, titleHeight);
    }
    if(stateArray[6] == 1 && stateArray[7] == 1 && activeAges.size() == 0 && (stateArray[8] == 1 || stateArray[9] == 1)){
      textAlign(CENTER);
      text("Total number of listeners and minutes listened, broken down by gender", width/2, titleHeight);
    }
    
    // gender and age breakdown
    if(stateArray[6] == 1 && stateArray[7] == 0 && activeAges.size() > 0 && (stateArray[8] == 1 || stateArray[9] == 1)){
      textAlign(CENTER);
      text("Total number of listeners, broken down by age and gender", width/2, titleHeight);
    }
    if(stateArray[6] == 0 && stateArray[7] == 1 && activeAges.size() > 0 && (stateArray[8] == 1 || stateArray[9] == 1)){
      textAlign(CENTER);
      text("Total minutes listened, broken down by age and gender", width/2, titleHeight);
    }
    if(stateArray[6] == 1 && stateArray[7] == 1 && activeAges.size() > 0 && (stateArray[8] == 1 || stateArray[9] == 1)){
      textAlign(CENTER);
      text("Total number of listeners and minutes listened, broken down by age and gender", width/2, titleHeight);
    }
  }
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // XY Marker Position//////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Get and store XY marker position
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i = 0; i < tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);
    if(tobj.getSymbolID() < markerQty){
      markerPosXY[tobj.getSymbolID()][0] = tobj.getX();
      markerPosXY[tobj.getSymbolID()][1] = tobj.getY();
    }
  }
  // Calculate and store distances
  IntList activeDetail = new IntList ();
  int detailMax = 2;
  float detailThreshold = 0.1;
  
  for (int i = 0; i < distanceArray.length ; i++){
    distanceArray[i] = distance( markerPosXY[20][0],   markerPosXY[20][1],
                                 markerPosXY[i+10][0], markerPosXY[i+10][1] );
    if(distanceArray[i] < detailThreshold && activeDetail.size() < detailMax){
      activeDetail.append(i);
    }
  }
  println(distanceArray);
  println(activeDetail);
  
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  // Draw Bar Graphs/////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  // -------- UI -------- //
  // Draw rectangle behind the detail bar graphs
  
  if(activeDetail.size() > 0 && stationCount > 0 && (stateArray[6] == 1 || stateArray[7] == 1 )){
    fill(245);
    rect(100,         detailY + 25,
         width -250, max_detail_height - 50);
  }
  
  // Prompt user for radio stations and measurement
  if( stationCount == 0 && stateArray[6] == 0 && stateArray[7] == 0 )
  {
    textAlign(CENTER);
    textFont(promptFont);
    fill(100);
    text("Please select at least one radion station and a measurement", width/2, height/2);
  }
  if( stationCount > 0 && stateArray[6] == 0 && stateArray[7] == 0 )
  {
    textAlign(CENTER);
    textFont(promptFont);
    fill(100);
    text("Please select a measurement", width/2, height/2);
  }
  if( stationCount == 0 && (stateArray[6] == 1 || stateArray[7] == 1 ))
  {
    textAlign(CENTER);
    textFont(promptFont);
    fill(100);
    text("Please select at least one radio station", width/2, height/2);
  }
  // -------------------- //
  
  
  
  
  if(stationCount != 0 && (stateArray[6]==1 || stateArray[7]==1) ){
    for(int i = 0; i < stationCount; i++){
     // Find maximum listener and minute value
        
        //Totals
        listener_value[i] = listenersTable.getInt(int(activeStations.get(i)), 1);
        minute_value[i] = minutesTable.getInt(int(activeStations.get(i)),1);
        
        //  with no gender breakdown
        if(stateArray[8]==0 && stateArray[9]==0){
          if(activeDetail.size() > 0){ 
            for(int j = 0; j < activeDetail.size(); j++){
              age_listener_value[i] = age_listener_value[i] +
                                      listenersTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 2 ) *
                                      listenersTable.getInt(int(activeStations.get(i)), 1);
              age_minute_value[i] = age_minute_value[i] +
                                    minutesTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 2 ) *
                                    minutesTable.getInt(int(activeStations.get(i)),1);
            }        
          }
        }
        // with gender breakdown
        if(stateArray[8]==1 || stateArray[9]==1){  
          if( activeDetail.size() > 0){  
            for(int j = 0; j <  activeDetail.size(); j++){
              if(stateArray[8]==1){
                age_listener_value[i]  = age_listener_value[i] +
                                             listenersTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 13 ) *
                                             listenersTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 2 ) *
                                             listenersTable.getInt(int(activeStations.get(i)), 1);
                age_minute_value[i]  = age_minute_value[i] +
                                           minutesTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 13 ) *
                                           minutesTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 2 )  *
                                           minutesTable.getInt(int(activeStations.get(i)), 1);
              }
              if(stateArray[9]==1){
                age_listener_value[i+6] = age_listener_value[i+6] +
                                           (1-listenersTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 13 )) *
                                            listenersTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 2 )  *
                                            listenersTable.getInt(int(activeStations.get(i)),1);
                age_minute_value[i+6] = age_minute_value[i+6] +
                                         (1-minutesTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 13 )) *
                                          minutesTable.getFloat(int(activeStations.get(i)), activeDetail.get(j) + 2 ) *
                                          minutesTable.getInt(int(activeStations.get(i)), 1);
              }
            }
          }
        }
      }
    
    max_listeners = max(listener_value);
    max_minutes = max(minute_value);
    max_listener_detail = max(age_listener_value);
    max_minutes_detail = max(age_minute_value);
    
    //round up maximum listeners and minutes values
    max_listeners = ceil(max_listeners / 1000) * 1000;
    max_minutes = ceil(max_minutes / 100000) * 100000;
    
    int maxHeight_line = -450;
        
    //////////////////////////
    // Draw reference lines //
    //////////////////////////
    if(gridMode > 0 && (stateArray[6] == 1 || stateArray[7] == 1)){
      PImage[] logos = new PImage[9];
      for(int i = 0; i < logos.length; i++){
        logos[i] = loadImage(i + ".png");
      }
      
      int refLabelY = 670;
      int refPosXMin = 100;
      int refPosXMax = 150;
      int numberLines = 21;                   // Number of reference lines
      int numberRefNumbers = 11;              // Number of reference numbers
      
      // Calculate and draw reference lines
      for(int i = 0; i < numberLines; i++){
        stroke(refLineColor[0],refLineColor[1],refLineColor[2]);
        if(i == 0 || i%2 == 0){ 
          strokeWeight(refLineWeight*1.45); }
        else{ strokeWeight(refLineWeight/2); }
        
        line( refPosXMin,       map(i, 0, numberLines-1, posY, posY + maxHeight),
              width-refPosXMax, map(i, 0, numberLines-1, posY, posY + maxHeight) );
      }
      
      // Calculate and draw reference numbers
      float[] refNumDividers = {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1};
      for(int i = 0; i < numberRefNumbers; i++){
        textFont(numberFont);
        fill(0); 
        if(stateArray[6] == 1){
          textAlign(RIGHT);
          if(i == 0){ text(0, refPosXMin, posY); }
          else{ text( int(max_listeners * refNumDividers[i-1]),
                      refPosXMin, posY + maxHeight * refNumDividers[i-1]); }
        }
        if(stateArray[7] == 1){
          textAlign(LEFT);
          if(i == 0){ text(0, width-refPosXMax, posY); }
          else{ text( int(max_minutes * refNumDividers[i-1] ),
                      width-refPosXMax, posY + maxHeight * refNumDividers[i-1]); }
        }
      }
      
      // listeners reference labels
      if(stateArray[6] == 1){
        textAlign(RIGHT);
        image(logos[7], refPosXMin-80, (refLabelY+40));                   // listeners Icon
        //listeners label on the side of y axis
        pushMatrix();
        translate(refPosXMin-60, (refLabelY-115));
        rotate(-PI/2);
        text("number of listeners", 0,0);
        popMatrix();
      }
      // minutes reference labels
      if(stateArray[7] == 1){
        textAlign(LEFT);
        image(logos[8], width-refPosXMax+80, (refLabelY+40));              // listeners Icon
        //minutes  label on the side of y axis
        pushMatrix();
        translate(width-refPosXMax+100, (refLabelY+10));
        rotate(-PI/2);
        text("minutes listened", 0,0);
        popMatrix();
      }
    }
    
    ///////////****************************************************************************************************************
    // Call bar graph function and draw it
    for(int i = 0; i < stationCount; i++){
      int currentStation = int(activeStations.get(i));
      
      barGraph( (width/(stationCount + 1)*(i+1) ) , int(activeStations.get(i)), stateArray[7], stateArray[6], activeAges,
                boolean(stateArray[8]), boolean(stateArray[9]), max_listeners, max_minutes, gridMode);
                
      if( activeDetail.size() > 0){
        try{       
          detailGraph( (width/(stationCount + 1)*(i+1) ) , int(activeStations.get(i)), stateArray[7], stateArray[6], activeAges,
                        activeDetail, boolean(stateArray[8]), boolean(stateArray[9]), max_listener_detail, max_minutes_detail, gridMode);
        }
        catch(IndexOutOfBoundsException e){
          println("..."); 
        }
      }
    }
    ///////////****************************************************************************************************************
    
    // Resets maximum values to 0 for listeners and minutes
    for(int i = 0; i < stationCount; i++){
      listener_value[i] = 0;
      minute_value[i] = 0;
    }
    for(int i = 0; i < 12; i++){
      age_listener_value[i] = 0;
      age_minute_value[i] = 0;
    }
    
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////TUIO/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Add Markers
void addTuioObject(TuioObject tobj){
  if( tobj.getSymbolID() < markerQty && stationCount == activeStations.size() ){
    markerID[tobj.getSymbolID()] = true;
    stateArray[tobj.getSymbolID()] = 1;
    
    //update Stations
    if(tobj.getSymbolID() >= 0 && tobj.getSymbolID() < 6){
      stationCount++;
      stationArray[tobj.getSymbolID()] = 1;
      activeStations.add(str(tobj.getSymbolID()));
    }
    //update Ages
    if(tobj.getSymbolID() >= 10 && tobj.getSymbolID() < 20){
      ageArray[tobj.getSymbolID()-10] = 1;
    }
    
    if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  }
}

// Remove Markers
void removeTuioObject(TuioObject tobj){
  if(tobj.getSymbolID() < markerQty && stationCount == activeStations.size() ){
    markerID[tobj.getSymbolID()] = false;
    stateArray[tobj.getSymbolID()] = 0;
    
    if(tobj.getSymbolID() >= 0 && tobj.getSymbolID() < 6){
      stationCount--;
      stationArray[tobj.getSymbolID()] = 0;
      activeStations.remove(str(tobj.getSymbolID()));
    }
    //update Ages
    if(tobj.getSymbolID() >= 10 && tobj.getSymbolID() < 20){
      ageArray[tobj.getSymbolID()-10] = 0;
    }
    //reset marker xy position to 0
    if(tobj.getSymbolID() < markerQty){
      markerPosXY[tobj.getSymbolID()][0] = 0;
      markerPosXY[tobj.getSymbolID()][1] = 0;
    }
    
    if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  }
}
// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
// --------------------------------------------------------------
