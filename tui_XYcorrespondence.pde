//---------------------------
// Function to calculate mean value in an array
float getMean(FloatList values){
  float sum = 0;
  for(int i = 0; i < values.size(); i++){
    sum = sum + values.get(i);
  }
  return sum/values.size();
}
// Function to calculate variance in an array
float getVariance(FloatList values, float meanFunction){
  float mean = meanFunction;
  float temp = 0;
  for(int i = 0; i < values.size(); i++){
    temp = temp + ( mean - values.get(i) ) *
                  ( mean - values.get(i) );
  }
  return temp/values.size();
}


//---------------------------

void setup() {
  size(1900, 1000);
  noStroke();
  
  listenersTable = loadTable("listeners.csv");
  
  // TUIO Setuo
  // periodic updates
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); // or callback updates 
  // create an instance of the TuioProcessing client
  tuioClient  = new TuioProcessing(this);
}

void draw()
{
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
  // Sort Stations based on X position
  IntList stationSorted = new IntList ();
  FloatList XPosSort = new FloatList ();
  FloatList YPosSort = new FloatList ();
  float XVariance = 0;
  float YVariance = 0;
  // If only one token on table, don't sort
  if(activeStations.size() == 1){
    stationSorted.append(int(activeStations.get(0)));
  }
  //If more than one token on table, sort  
  if(activeStations.size() > 1){
    for(int i = 0; i < activeStations.size(); i++){
      XPosSort.append(markerPosXY[int(activeStations.get(i))+10][0]);
      YPosSort.append(markerPosXY[int(activeStations.get(i))+10][1]);
    }  
    // Sort arrays and get variance
    XPosSort.sort();
    YPosSort.sort();
    XVariance = getVariance(XPosSort, getMean(XPosSort));
    YVariance = getVariance(YPosSort, getMean(YPosSort));
    // Check if tokens are aligned in X or Y axis
    if(XVariance > YVariance){
      //Sort X position
      for(int j = 0; j < activeStations.size(); j++){
        for(int i = 0; i < activeStations.size(); i++){
          if(XPosSort.get(j) == markerPosXY[int(activeStations.get(i))+10][0]){
            stationSorted.append( int(markerPosXY[int(activeStations.get(i))][2]) );
    } } } }
    else{
      //Sort Y position
      for(int j = 0; j < activeStations.size(); j++){
        for(int i = 0; i < activeStations.size(); i++){
          if(YPosSort.get(j) == markerPosXY[int(activeStations.get(i))+10][1]){
            stationSorted.append( int(markerPosXY[int(activeStations.get(i))][2]) );
    } } } }
  }
}
