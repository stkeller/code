// Global Variables
const int speaker = 9;
int incomingByte; 
int ledPins[] = {5, 6, 7};
float freq = 600;

void setup(){
  Serial.begin(9600);
  
  for (int thisPin = 0; thisPin < 3; thisPin++)  {
    pinMode(ledPins[thisPin], OUTPUT);
  }
}

void loop(){
  if (Serial.available() > 0) {
    // read the oldest byte in the serial buffer:
    incomingByte = Serial.read();
    // if it's a capital H (ASCII 72), turn on the LED:
    if (incomingByte == 'H') {
      freq = random(220, 600);
      float root       = freq * 1;
      float minSecond  = freq * 1.0534;
      float second     = root * 1.125;
      float minThird   = root * 1.18518;
      float third      = root * 1.265625;
      float fourth     = root * 1.33333;
      float fifth      = root * 1.5;
      float minSixth   = root * 1.5802;
      float sixth      = root * 1.6875;
      float minSeventh = root * 1.7777;
      float seventh    = root * 1.8984375;
      float eighth     = root * 2;

      int arpSelector = random(0,7);
      
      if(arpSelector == 0){
        float notes[] = {freq, minSecond, minSixth};
        command(speaker, ledPins, notes); }
        
      if(arpSelector == 1){
        float notes[] = {freq, third, fifth};
        command(speaker, ledPins, notes); }
        
      if(arpSelector == 2){
        float notes[] = {freq, minThird, fifth};
        command(speaker, ledPins, notes); }
     
      if(arpSelector == 3){
        float notes[] = {freq, minThird, minSixth};
        command(speaker, ledPins, notes); }
        
      if(arpSelector == 4){
        float notes[] = {freq, fifth, minSeventh};
        command(speaker, ledPins, notes); }   
        
      if(arpSelector == 5){
        float notes[] = {freq, fifth, seventh};
        command(speaker, ledPins, notes); }   
        
      if(arpSelector == 6){
        float notes[] = {freq, fourth, minSeventh};
        command(speaker, ledPins, notes); } 
      
      }
    }
  
  if (incomingByte == 'L') {
    noTone(speaker);
    for(int i = 0; i < 3; i++){
      digitalWrite(ledPins[i], LOW);
    }
  }
}

// Light and Sound Function
void command(int speaker, int ledPins[], float notes[]){
  for(int i = 0; i < 3; i++){
    noTone(speaker);
    digitalWrite(ledPins[i], HIGH);

    delay(150);
    
    digitalWrite(ledPins[i], LOW);
    tone(speaker, notes[i]);
    delay(100);
    noTone(speaker);
  }
}
