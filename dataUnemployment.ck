//Data Sets //

// Men Unemployment Rate per Country
[7.6,12.2,8.1,4.9,6.3,8.0,6.2,5.0,4.9,4.0,4.5,13.6,5.6,4.2,9.8,7.1,0.9,3.1,1.8,2.6,26.0,15.3,6.1,3.7,12.3,0.7,0.3,3.1,7.8,23.3,3.8,1.1,6.1,
3.9,3.0,9.1,21.3,11.7,6.0,13.7,2.4,7.8,5.8,7.7,54.6,12.0,9.3,4.9,8.4,27.4,13.1,11.7,2.6,6.4,8.3,8.8,19.1,16.7,6.2,3.5,7.7,14.9,10.0,9.6,
19.1,12.8,2.9,4.6,17.2,6.2,4.3,11.0,7.8,3.3,9.1,16.2,17.4,2.8,5.6,7.6,9.6,4.8,11.0,4.6,56.4,2.0,7.3,1.3,17.6,8.6,23.0,3.4,17.8,3.8,1.7,
5.4,3.3,7.9,7.2,6.1,27.6,19.0,23.9,5.2,5.3,2.5,3.0,19.5,8.4,3.4,4.7,32.5,3.1,4.5,8.0,6.3,7.4,1.7,3.7,7.3,3.4,23.1,4.0,3.7,4.2,4.3,4.4,
5.8,9.0,12.4,18.2,0.2,3.6,7.7,27.6,7.9,7.0,0.9,20.2,4.3,10.0,18.3,4.4,1.2,11.0,3.5,7.9,18.3,14.4,6.1,4.5,2.6,13.5,8.2,31.0,22.3,21.2,3.5,
7.0,20.0,7.6,3.7,5.7,31.8,0.7,3.5,9.2,4.9,3.1,8.8,2.0,8.4,2.8,9.4,4.5,4.1,7.7,1.7,4.2] @=> float menRate[];

// Women Unemployment Rate per Country
[9.5,15.9,19.1,6.0,9.5,8.8,8.5,6.5,5.3,4.3,6.4,13.7,20.0,7.4,12.5,7.2,0.4,2.3,4.5,4.4,29.9,19.9,11.0,6.7,10.0,0.3,0.1,4.5,7.0,22.6,4.1,0.3,
8.7,2.8,2.1,15.0,16.9,14.8,10.3,13.2,2.7,7.7,7.9,7.5,68.6,9.5,16.4,22.6,5.1,18.5,11.8,22.6,3.9,12.9,7.1,9.7,16.1,13.1,5.6,3.6,4.0,21.4,6.7,
10.9,25.8,9.8,6.6,1.7,25.7,8.3,5.6,10.9,6.2,4.3,16.8,22.5,10.6,2.0,5.6,9.6,17.2,4.1,21.2,6.2,40.7,1.8,9.4,1.4,13.1,10.1,28.0,4.1,13.0,6.3,
3.5,10.0,3.6,23.8,10.9,7.0,37.3,22.5,44.0,12.3,5.2,5.2,3.6,20.0,10.2,1.3,8.8,43.0,2.4,4.4,12.5,6.8,8.8,0.9,4.4,5.8,3.1,26.8,8.7,4.9,4.9,
1.3,7.4,10.1,10.4,13.1,12.8,3.3,3.1,5.6,31.8,6.8,6.2,0.4,15.1,5.9,18.5,21.4,6.2,4.5,24.5,15.9,13.6,20.4,16.4,4.9,2.3,3.2,13.5,8.2,33.7,
27.7,22.2,7.7,13.7,26.0,7.5,4.5,22.5,30.8,0.6,6.2,11.3,8.6,5.1,6.8,12.0,7.1,5.8,8.5,7.7,5.2,9.3,2.4,4.1] @=> float womenRate[];

// Year data was collected
[2005.0,2009,2010,2000,2002,2001,2011,2007,2011,2011,2011,2011,2004,2009,2011,2011,2002,2000,2011,2009,2011,2006,2009,1991,2011,1990,2011,
2010,2011,1990,2008,1993,2011,2011,2011,2010,1991,2001,2011,2011,2010,2011,2011,2011,2002,2001,2010,2010,2010,1983,2011,2006,2005,2007,
2011,2011,1993,2011,2011,2006,1991,2011,2006,2001,2011,2002,2011,1994,2011,1999,2010,2011,2011,2010,2008,2006,2011,2006,2011,2011,2011,
2011,2011,2011,2009,2005,2008,2005,2011,2007,2008,2010,2011,2011,2005,2004,2010,2006,2004,2011,1999,2011,2008,2011,2011,2000,2005,2011,
2011,1997,1990,2008,2008,2011,2008,2011,2010,2001,1986,2005,2011,2010,2008,2005,2011,2000,2011,2011,2011,2011,2011,2011,2011,2011,2011,
2011,2011,1996,1998,2001,2007,1991,2001,2007,2006,2009,2006,2010,2003,2005,2004,2011,2011,2011,1999,2011,2011,2010,2004,1997,2011,2011,
2010,2011,2011,2008,2011,2005,2009,2011,2008,2011,2006,2011,2011,2009,2011,2011,2004] @=> float year[];

//                       //
// Data Helper Functions //
//                       //

// Find Minimun Value
fun float minVal( float dataArray[] )
{
    dataArray[0] => float minimum;
    for( 1 => int i; i < dataArray.cap(); i++ )
    {
        if( minimum > dataArray[i] )
        {
            dataArray[i] => minimum;
        }
    }
    return minimum;
}

// Find Maximun Value
fun float maxVal( float dataArray[] )
{
    dataArray[0] => float minimum;
    for( 1 => int i; i < dataArray.cap(); i++ )
    {
        if( minimum < dataArray[i] )
        {
            dataArray[i] => minimum;
        }
    }
    return minimum;
}
// Data Normalization
fun float arrayNormalization( string dataName,float dataArray[], float oldMin,
                              float newMin, float oldMax, float newMax)
{
    for( 0 => int i; i < dataArray.cap(); i++ )
    {
        // Normalization Equation (newvalue = (max'-min')/(max-min)*(value-max)+max')
        <<< dataName, "Old Value = ", dataArray[i] >>>;
        (newMax - newMin) / (oldMax - oldMin) * (dataArray[i] - oldMax) + newMax
         => dataArray[i];
        <<< "New Value = ", dataArray[i] >>>;
    }
}

//                   //
// Data Manipulation //
//                   //

// Find mininum and maximun values

// Men unemployment min and max
minVal(menRate) => float menMin;
maxVal(menRate) => float menMax;
// Women unemployment min and max
minVal(womenRate) => float womenMin;
maxVal(womenRate) => float womenMax;
// Year  min and max
minVal(year) => float yearMin;
maxVal(year) => float yearMax;
// Print results
<<< "Men minimum =", menMin >>>;
<<< "Men maximum =", menMax >>>;
<<< "Women minimum =", womenMin >>>;
<<< "Women maximum =", womenMax >>>;
<<< "Year minimum =", yearMin >>>;
<<< "Year maximum =", yearMax >>>;

// Normalize Data
0 => float newMinVal;
100 => float newMaxVal;
arrayNormalization("Men Unemployment", menRate, menMin, newMinVal, menMax, newMaxVal);
arrayNormalization("Women Unemployment", womenRate, womenMin, newMinVal, womenMax, newMaxVal);
arrayNormalization("Year", year, yearMin, 0, yearMax, 4);


// Audio //

// Synth 1 Parameters
TriOsc sinePad => ADSR sineEnv => NRev sineReverb => Pan2 sinePan1 => dac;
( 2::second, .2::second, .5, 1::second ) => sineEnv.set;
.15 => sineReverb.mix;
.5 => sinePan1.pan;
// Synth 2 Parameters
TriOsc sinePad2 => ADSR sineEnv2 => NRev sineReverb2 => Pan2 sinePan2 => dac;
( 2::second, .2::second, .5, 1::second ) => sineEnv2.set;
.15 => sineReverb2.mix;
-.5 => sinePan2.pan;

// Note Duration
1 => float quarter;
quarter * 2 => float half;
half * 2 => float whole;
quarter / 2 => float eighth;
eighth / 2 => float sixteenth;

48 => int rootNote;
rootNote => int rootNoteNew;

//                     //
// Song Helper Funcion //
//                     //

// Note Frequency
fun int noteFreq( float input )
{
    if( input < 10 )
    {
        return rootNoteNew + 2; // Minor Second Interval
    }
    else if( input < 20 )
    {
        return rootNoteNew + 4; // Major Third Interval
    }
    else if( input < 30 )
    {
        return rootNoteNew + 7; // Fifth Interval
    }
    else if( input < 40 )
    {
        return rootNoteNew + 11; // Major Seventh Interval
    }
    else if( input < 50 )
    {
        return rootNoteNew + 12; // +1 Octave
    }
    else if( input < 60 )
    {
        return rootNoteNew + 14; // Minor Second Interval +1  Octave
    }
    else if( input < 70 )
    {
        return rootNoteNew + 16; // Major Third Interval +1 Octave
    }
    else if( input < 80 )
    {
        return rootNoteNew + 19; // Fifth Interval +1 Octave
    }
    else if( input < 90 )
    {
        return rootNoteNew + 23; // Major Seventh Interval +1 Octave
    }
    else if( input <= 100 )
    {
        return rootNoteNew + 24; // +2 Octaves
    }
}

// Note Duration 
fun float noteDur( float input )
{
    if( input == 0 )
    {
        return whole;
    }
    else if( input == 1 )
    {
        return half;
    }
    else if( input == 2 )
    {
        return quarter;
    }
    else if( input == 3 )
    {
        return eighth;
    }
    else if( input == 4 )
    {
        return sixteenth;
    }
}

// Gain Control based on Data
fun float setGain( float input, float oldMin,
                   float newMin, float oldMax, float newMax)
{
    (newMax - newMin) / (oldMax - oldMin) * (input - oldMax) + newMax => float gainVal;
    return gainVal;
}

// Sequencer
fun void sequencer( float array1[], float array2[], float array3[] )
{
    for( 0 => int i; i < array1.cap(); i++ )
    {
        // Synth 1
        rootNote => rootNoteNew;
        Std.mtof(noteFreq(array1[i])) => sinePad.freq;
        setGain(array1[i], newMinVal, .2, newMaxVal, .45) => sinePad.gain;
        // Synth 2
        rootNote => rootNoteNew;
        Std.mtof(noteFreq(array2[i])) => sinePad2.freq;
        setGain(array2[i], newMinVal, .2, newMaxVal, .45) => sinePad2.gain;
        
        1 => sineEnv.keyOn;
        1 => sineEnv2.keyOn;
        
        // Advance Time based on year data was retrieved
        noteDur(array3[i])::second => now;
    }
}

// Play Song
while( true )
{
    sequencer(menRate, womenRate, year);
}
