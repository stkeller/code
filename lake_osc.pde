// Glitch code based on:
// http://pastebin.com/ReY90cyk

import processing.video.*;
import oscP5.*;
import netP5.*;

int min=25, max=120, off=8;
int value1, value2, value3, value4, 
    value5, value6, value7, value8;

Movie video;
OscP5 oscP5;

void setup(){
 size(800, 600);
 video = new Movie(this, "Lake_b.mov");
 video.loop(); 
 oscP5 = new OscP5(this, 7400);
}

void movieEvent(Movie video) {
 video.read(); 
}

void draw() {
  float red   = map(value1, 0, 127, 0, 255);
  float blue  = map(value2, 0, 127, 0, 255);
  float green = map(value3, 0, 127, 0, 255);
  
  float minVal = map(value5, 0, 127, 0, min);
  float maxVal = map(value6, 0, 127, 0, max);
  float offVal = map(value7, 0, 127, 0, off);
  
  //Create Squares
  int x = (int)random(width);
  int y = (int)random(height);
  int w = (int)random(minVal, maxVal);
  int h = (int)random(minVal, maxVal);
  int x2 = x + (int)random(-offVal, offVal);
  int y2 = y + (int)random(-offVal, offVal);  
  PImage temp = createImage(w, h, RGB);
  temp.loadPixels();
  for (int i=0; i<w; i++) {
    for (int j=0; j<h; j++) {
      temp.pixels[i+j*w]=video.get(x+i, y+j);
    }
  }
  
  video.loadPixels();
  temp.updatePixels();
  tint(red, green, blue, 120);
  image(temp, x2, y2);
}

// OSC Messages
void oscEvent(OscMessage theOscMessage) 
{
  //Control 1
  if (theOscMessage.checkAddrPattern("/ctrl1/v") == true) {
    int firstValue1 = theOscMessage.get(0).intValue();  
    value1 = firstValue1;
  }
  //Control 2
  if (theOscMessage.checkAddrPattern("/ctrl2/v") == true) {
    int firstValue2 = theOscMessage.get(0).intValue();  
    value2 = firstValue2;
  }
  //Control 3
  if (theOscMessage.checkAddrPattern("/ctrl3/v") == true) {
    int firstValue3 = theOscMessage.get(0).intValue();  
    value3 = firstValue3;
  }
  //Control 4
  if (theOscMessage.checkAddrPattern("/ctrl4/v") == true) {
    int firstValue4 = theOscMessage.get(0).intValue();  
    value4 = firstValue4;
  }
  //Control 5
  if (theOscMessage.checkAddrPattern("/ctrl5/v") == true) {
    int firstValue5 = theOscMessage.get(0).intValue();  
    value5 = firstValue5;
  }
  //Control 6
  if (theOscMessage.checkAddrPattern("/ctrl6/v") == true) {
    int firstValue6 = theOscMessage.get(0).intValue();  
    value6 = firstValue6;
  }
  //Control 7
  if (theOscMessage.checkAddrPattern("/ctrl7/v") == true) {
    int firstValue7 = theOscMessage.get(0).intValue();  
    value7 = firstValue7;
  }
  //Control 8
  if (theOscMessage.checkAddrPattern("/ctrl8/v") == true) {
    int firstValue8 = theOscMessage.get(0).intValue();  
    value8 = firstValue8;
  }
}
