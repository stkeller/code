/*
This file uses a Ultrasonic Sensor code that was
 modified from the a code found on: 
 http://winkleink.blogspot.ca/2012/05/arduino-hc-sr04-ultrasonic-distance.html
 and modified codes from Mozzi examples and reference documentation.
 */

// Include Mozzi Classes
#include <MozziGuts.h>;
#include <mozzi_config.h>
#include <Oscil.h>;
#include <tables/sin1024_int8.h>;
#include <tables/saw2048_int8.h>;
#include <tables/cos2048_int8.h>;
#include <mozzi_rand.h>;
#include <LowPassFilter.h>;

#define CONTROL_RATE 64

Oscil <2048, AUDIO_RATE> osc(SAW2048_DATA); // Oscilator waveform
Oscil <COS2048_NUM_CELLS, CONTROL_RATE> filterMod(COS2048_DATA); // Low Pass Filter waveform
Oscil <2048, CONTROL_RATE> kvib(SAW2048_DATA); // Vibrato Waveform
LowPassFilter lpf;

int gain;
// Ultrasonic Sensor Pins
int trigPin = 2;
int echoPin = 4;

void setup(){
  Serial.begin(115200);
  startMozzi(CONTROL_RATE);
  lpf.setResonance(20);
  kvib.setFreq(16.5f);
  filterMod.setFreq(1.3f);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void updateControl(){
  // Accelerometer Pins
  int xRead = mozziAnalogRead(0);
//  int yRead = mozziAnalogRead(1);
//  int zRead = mozziAnalogRead(2);

  // Distance Sensor
  int duration, distance;
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(100);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  distance = (duration/2) / 29.1;
  int freq = map(distance, 4, 200, 100, 660);
  //int freq = 300;

  float depth = 1; // vibrato depth
  float vibrato = depth * kvib.next();

  if (rand(CONTROL_RATE/2) == 0) // Low Pass Filter Frequency
  {
    filterMod.setFreq((float)rand(255)/64);
  }
  byte cutoff_freq = 100 + filterMod.next()/2;
  lpf.setCutoffFreq(cutoff_freq);

  if(xRead > 500){
    osc.setFreq(freq);
  }
  else if(xRead < 500){
    osc.setFreq(freq*4 + vibrato);
  }    
}

int updateAudio(){
  char audio = lpf.next(osc.next());
  return (int) audio;
}

void loop(){
  audioHook(); 
}
