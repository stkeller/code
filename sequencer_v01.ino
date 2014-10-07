// Time Variables
int quarter = 120;
int eighth = quarter / 2;
int sixteenth = eighth / 2;
int half = quarter * 2;
int whole = half *2;

int noteOffDur = 25;


// Note Array
byte notes[] = {72, 60, 65, 60,
                60, 60, 65, 60};
int noteDur[] = {half, quarter, quarter, quarter,
                 half, quarter, quarter, quarter};

           
// Sequencer Function            
void sequencer(int repeat, int seqSize, byte noteSeq[], int noteDur[])
{
  for (int r = 0; r < repeat; r++){
    for (byte i = 0; i < seqSize; i++)
    {
      // Note On
      MidiNote(144, noteSeq[i], 127);
      delay(noteDur[i]);
      // Note Off
      MidiNote(128, noteSeq[i], 0);
      delay(noteOffDur);
    }
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

void loop()
{
  sequencer(1, sizeof(notes), notes, noteDur);
}
