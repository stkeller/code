int noteOnDur = 60;
int noteOffDur = 25;

int arpSize = 12;

// Note Sequencer Function
void seq(int seqType[]){
  for (byte i = 0; i < arpSize; i++){
        // Note On
        MidiNote(1, seqType[i], 127);
        delay(noteOnDur);
        // Note Off
        MidiNote(1, seqType[i], 0);
        delay(noteOffDur); }
}

// Arppegiator Function            
void arp(int root, int repeat, int type)
{
  int octave = root+12;
  
  int arpMaj[] = {root, root+4, root+7, octave,
                  octave+4, octave+7, octave+4, octave+12,
                  octave+7, octave+4, octave, root};
  int arpMin[] = {root, root+3, root+7, octave,
                  octave+3, octave+7, octave+3, octave+12,
                  octave+7, octave+3, octave, root};
  int arpDim[] = {root, root+3, root+6, octave,
                  octave+3, octave+6, octave+3, octave+12,
                  octave+6, octave+3, octave, root};
  int arpAug[] = {root, root+4, root+8, octave,
                  octave+4, octave+8, octave+4, octave+12,
                  octave+8, octave+4, octave, root};
  int arpMaj7[] = {root, root+4, root+7, root+11,
                   octave, octave+4, octave+7, octave+11,
                   octave+12, octave+7, octave, root};
  int arp7[] = {root, root+4, root+7, root+10,
                octave, octave+4, octave+7, octave+10,
                octave+12, octave+7, octave, root};
  int arpMin7[] = {root, root+3, root+7, root+10,
                   octave, octave+3, octave+7, octave+10,
                   octave+12, octave+7, octave, root};
  int arpDimMin[] = {root, root+3, root+6, root+10,
                     octave, octave+3, octave+6, octave+10,
                     octave+12, octave+6, octave, root};
  int arpDimDim[] = {root, root+3, root+6, root+9,
                     octave, octave+3, octave+6, octave+9,
                     octave+12, octave+6, octave, root};
                  
  // Type 1 = Major Triad
  if(type == 1){
    for (int r = 0; r < repeat; r++){
      seq(arpMaj);}
  }
  // Type 2 = Minor Triad
  else if(type == 2){
    for (int r = 0; r < repeat; r++){
      seq(arpMin);}
  }
  // Type 3 = Diminished Triad
  else if(type == 3){
    for (int r = 0; r < repeat; r++){
      seq(arpDim);}
  }
  // Type 4 = Augmented Triad
  else if(type == 4){
    for (int r = 0; r < repeat; r++){
      seq(arpAug);}
  }
  // Type 5 = Major Major Seventh
  else if(type == 5){
    for (int r = 0; r < repeat; r++){
      seq(arpMaj7);}
  }
  // Type 6 = Major Minor Seventh
  else if(type == 6){
    for (int r = 0; r < repeat; r++){
      seq(arp7);}
  }
  // Type 7 = Minor Seventh
  else if(type == 7){
    for (int r = 0; r < repeat; r++){
      seq(arpMin7);}
  }
  // Type 8 = Diminished Minor Seventh
  else if(type == 8){
    for (int r = 0; r < repeat; r++){
      seq(arpDimMin);}
  }
  // Type 9 = Diminished Diminished Seventh
  else if(type == 9){
    for (int r = 0; r < repeat; r++){
      seq(arpDimDim);}
  }
}

// MIDI Protocol
void MidiNote(byte channel, byte note, byte velocity)
{
  byte midiMessage= 0x90 + (channel - 1);
  Serial.write(midiMessage);
  Serial.write(note);
  Serial.write(velocity);
}

//
//Main Program//
//

void setup()
{
  Serial.begin(31250);
}

/* Chord List
1 = Major, 2 = Minor, 3 = Diminished, 4 = Augmented
5 = Maj7. 6 =x7, 7 = min7, 8 = halfdim, 9 = dim7dim
*/

void loop()
{
  // Summertime
  // A
  arp(52, 2, 4);
  for( int x = 0; x < 3; x++) {
    arp(45, 1, 7);
    arp(52, 1, 6); }
  arp(45, 2, 7);
  arp(50, 1, 7);
  arp(53, 1, 1);
  arp(50, 1, 7);
  arp(45, 1, 9);
  arp(47, 1, 4);
  arp(47, 1, 6);
  arp(52, 1, 6);
  arp(46, 1, 6);
  // B
  for( int x = 0; x < 3; x++) {
    arp(45, 1, 7);
    arp(52, 1, 6); }
  arp(45, 1, 2);
  arp(50, 1, 6);
  arp(48, 1, 5);
  arp(45, 1, 7);
  arp(50, 1, 6);
  arp(43, 1, 6);
  arp(45, 2, 7);
  arp(47, 1, 9);
  arp(52, 1, 4);
}
