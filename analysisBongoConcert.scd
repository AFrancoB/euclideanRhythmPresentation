//Bjorklund app:
// http://www.groovemechanics.com/euclid/

// Concierto para Bongo
// https://www.youtube.com/watch?v=pBeB7rBdx2g



(
s.boot;

(
SynthDef(\snare, {|freq=500, amp|
	var sig, env;
	sig= RLPF.ar(WhiteNoise.ar(amp), freq*[1,2,3,4,5,6,7,8], 0.8)!2;
	env= EnvGen.kr(Env.perc(0.001,0.075), doneAction:2);

	Out.ar(0, sig*env)
}
).add
)
);

~tema= Bjorklund(5,8).rotate(2); // first cell of the theme
~tema= ~tema ++ Bjorklund(5,8);  // first and second cell
~tema= ~tema ++ Bjorklund(5,8).rotate(2)++[1]++(0!7); // third cell added + last measure
// consecuente de la frase con un break de silencio en la ultima parte;

(
{FreeVerb2.ar(In.ar(0),In.ar(1), 0.1, 0.2, 0.5, mul:0.2)}.play;
Pbind(\instrument, \snare, \dur, 0.1,\amp, Pseq(~tema,2)).play;
);

// first part of the solo;

~solo= Bjorklund(2,3).stutter(2);
~solo= ~solo ++ ~solo ++ Bjorklund(4,4) ++ Bjorklund(0,16);
~accent= Bjorklund(3,17).reverse ++ Bjorklund(0,15);


(
{FreeVerb2.ar(In.ar(0),In.ar(1), 0.1, 0.2, 0.5, mul:0.2)}.play;
Pbind(\instrument,\snare, \dur, 0.1, \amp, Pseq([Pseq(~tema,2),Pseq(~solo,2)],1)).play;
Pbind(\instrument,\snare, \dur, 0.1, \amp, Pseq([Pseq(~tema,2),Pseq(~accent,2)],1), \freq, 750).play;
)

~solo2= Bjorklund(3,8).stutter(2);

(
{FreeVerb2.ar(In.ar(0),In.ar(1), 0.1, 0.2, 0.5, mul:0.2)}.play;
Pbind(\instrument, \snare, \dur, 0.12, \amp, 1, \bjork, Pseq(~solo2,inf), \freq, Pfunc{|event|  if( event[\bjork]==1, {500}, {250})} ).trace.play;
)


