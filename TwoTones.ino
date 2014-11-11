#include <Tone.h>
Tone tone1;
Tone tone2;

int potPint = 0;
int val = 0;

int speakerA = 9;
int speakerB = 11;

long lastChange1;
long lastChange2;

int musicTempo1 = 900;
int musicTempo2 = 600;

int toneCounter1 = 0;
int toneCounter2 = 0;

////////////////////
void setup()
{
  tone1.begin(speakerA);
  tone2.begin(speakerB);
}

void loop()
{
  // Potentionmeter
  val = analogRead(potPint);
  float freq = map(val, 0, 1024, 220, 880);
  //Music notes variables
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

  float notesA[] = {
    root, minThird, fifth,
    minThird, fifth, minSeventh,
    eighth, fifth, minThird};

  float notesB[] = {
    root, fifth / 2,
    root, root / 2,
    minSixth, root / 2};
    

  if((millis() - lastChange1) >= musicTempo1)
  {
    lastChange1 = millis();  //store the time that you changed
    if(toneCounter1 <= 9){
      toneCounter1 = toneCounter1 + 1; 
    }
    else{
      toneCounter1 = 0;
    }   
  }
  if((millis() - lastChange2) >= musicTempo2)
  {
    lastChange2 = millis();  //store the time that you changed
    if(toneCounter2 <= 6){
      toneCounter2 = toneCounter2 + 1; 
    }
    else{
      toneCounter2 = 0;
    }   
  }

  tone1.play(notesA[toneCounter1]);
  tone2.play(notesB[toneCounter2]);
}
