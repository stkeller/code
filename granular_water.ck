// OSC Receiver
// https://gist.github.com/stuntgoat/2439549

OscRecv recv;
7401 => recv.port;
recv.listen();
recv.event( "/note/n, i" ) @=> OscEvent oe;

// import sound files
me.sourceDir() + "/Audio/Water_8.wav" => string waterFile1;
if( me.args() ) me.arg(0) => waterFile1;
    
me.sourceDir() + "/Audio/Water_9.wav" => string waterFile2;
if( me.args() ) me.arg(0) => waterFile2;
    
me.sourceDir() + "/Audio/Water_10.wav" => string waterFile3;
if( me.args() ) me.arg(0) => waterFile3;
    
me.sourceDir() + "/Audio/Water_4.wav" => string waterFile4;
if( me.args() ) me.arg(0) => waterFile4;
    
me.sourceDir() + "/Audio/Water_5.wav" => string waterFile5;
if( me.args() ) me.arg(0) => waterFile5;
    
me.sourceDir() + "/Audio/Water_6.wav" => string waterFile6;
if( me.args() ) me.arg(0) => waterFile6;
    
me.sourceDir() + "/Audio/Water_7.wav" => string waterFile7;
if( me.args() ) me.arg(0) => waterFile7;

// Mixer
Gain waterGain => JCRev reverb => dac;
SndBuf water1 => Envelope waterEnv1 => waterGain;
SndBuf water2 => Envelope waterEnv2 => waterGain;
SndBuf water3 => Envelope waterEnv3 => waterGain;
SndBuf water4 => Envelope waterEnv4 => waterGain;
SndBuf water5 => Envelope waterEnv5 => waterGain;
SndBuf water6 => Envelope waterEnv6 => waterGain;
SndBuf water7 => Envelope waterEnv7 => waterGain;

.9  => waterGain.gain;
.8  => water1.gain;
.8  => water2.gain;
.8  => water3.gain;
.25 => water4.gain;
.25 => water5.gain;
.25 => water6.gain;
.3  => water7.gain;


// load files
waterFile1 => water1.read;
waterFile2 => water2.read;
waterFile3 => water3.read;
waterFile4 => water4.read;
waterFile5 => water5.read;
waterFile6 => water6.read;
waterFile7 => water7.read;

// Grain Function
fun void grain( SndBuf grainName, Envelope envName )
{ 
    Math.random2(0, grainName.samples()) => grainName.pos;
    Math.random2f(.6, 1.4) => grainName.rate;
        
    1000::ms => envName.duration;
    envName.keyOn();
    Math.random2f(40, 400)::ms => now;
    envName.keyOff();    
    500::ms => now;
}

//
while (true){
    oe => now;
    
    while ( oe.nextMsg() != 0 )
    { 
        // reverb control (based on note range 44-51)
        0 + (oe.getInt() - 44)*(.6 - 0)/(51 - 44) => float revVal;
        revVal => reverb.mix;
        
        for( 0 => int i; i < Math.random2(5, 100); i++ ) {
        Math.random2(0, 11) => int randGrain;
        // If - Case 1
        if ( ( randGrain == 1 ) || (randGrain == 2) )
            {
                spork ~ grain( water1, waterEnv1 );
            }
        // If - Case 2    
        else if ( ( randGrain == 3 ) || (randGrain == 4) )
            {
                spork ~ grain( water2, waterEnv2 );
            }
        // If - Case 3
        else if ( ( randGrain == 5 ) || (randGrain == 6) )
            {
                spork ~ grain( water3, waterEnv3 );
            }
        // If - Case 4
        else if ( randGrain == 7 )
            {
                spork ~ grain( water4, waterEnv4 );
            }
        // If - Case 5
        else if ( randGrain == 8 )
            {
                spork ~ grain( water5, waterEnv5 );
            }
        // If - Case 6
        else if ( randGrain == 9 )
            {
                spork ~ grain( water6, waterEnv6 );
            }
        // If - Case 6
        else if ( randGrain == 10 )
            {
                spork ~ grain( water7, waterEnv7 );
            }
        Math.random2f(.005, .08)::second => now;
        }
    }
}
