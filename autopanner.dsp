declare name 		"autopanner";
declare version 	"1.0";
declare author 		"Abraham Walters";
declare license 	"BSD";
declare copyright 	"(c)quid 2021";

import("filter.lib");
import("music.lib");
import("stdfaust.lib");

depth = hslider("depth", 1, 0, 15, 0.01) : smooth(0.999);
enabled = checkbox("enabled");
gain = hslider("gain", 0.1, 0, 1, 0.01) : smooth(0.999);
rate = hslider("rate", 0.5, 0, 10, 0.01) : smooth(0.999);

tremolo = hgroup("tremolo", osc(depth) * enabled);

volume = gain * (1 + tremolo);

left = 1 + osc(rate);
right = 1 - osc(rate);

autopanner = _ <: *(left * volume), *(right * volume);
process = no.noise : autopanner;
