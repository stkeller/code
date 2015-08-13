import controlP5.*;
ControlP5 cp5;

int arraySize = 100;

Button[] buttonArray = new Button[arraySize];
Button button1;

void setup()
{
  size(500,500);
  
  cp5 = new ControlP5(this);
  for(int i = 0; i < 10; i++){
    for(int j = 0; j< 10; j++){
      int arrayNumber = int(str(i)+str(j));
      buttonArray[arrayNumber] = cp5.addButton("button"+str(i)+str(j))
        .setPosition(i*50, j*50)
        .setSize(40,40).setColorBackground(color(0))
        .setColorLabel(color(0));
  }}
}
void draw(){}

public void button00(){
  int randGray = int(random(220));
  int randRed = int(random(220));
  int randGreen = int(random(220));
  int randBlue = int(random(220)); 
  for(int i = 0; i < 100; i++){
    buttonArray[int(random(arraySize))]
      .setColorBackground(color(randGray))
      .setColorLabel(color(randGray));
  }
  buttonArray[int(random(arraySize))]
    .setColorBackground(color(randRed, randGreen, randBlue))
    .setColorLabel(color(randRed, randGreen, randBlue));
}

public void button01(){
  int randRed = int(random(220));
  int randGreen = int(random(220));
  int randBlue = int(random(220)); 
  for(int i = 0; i < 60; i++){
    buttonArray[int(random(arraySize))]
      .setColorBackground(color(randRed, randGreen, randBlue))
      .setColorLabel(color(randRed, randGreen, randBlue));
  }
}

public void button02(){ 
  for(int i = 0; i < 60; i++){
    int randRed = int(random(220));
    int randGreen = int(random(220));
    int randBlue = int(random(220));
    buttonArray[int(random(arraySize))]
      .setColorBackground(color(randRed, randGreen, randBlue))
      .setColorLabel(color(randRed, randGreen, randBlue));
  }
}
