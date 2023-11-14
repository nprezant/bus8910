use <HatBracket.scad>

// seat square side length (in)
seat_bolt_dist = 11;

// swivel base square side length (in)
base_bolt_dist = 7;

// Sheet thickness (in)
t = 0.250;

// Total height (in)
h = 1.5;

// Minimum padding around bolt holes (in)
padding = 0.75;

// Bolt stuff
dia = 0.3;

rotate([0, 0, $t*360]) {

color("LightSkyBlue") {
  bracket(seat_bolt_dist, base_bolt_dist, t, h, padding, dia, center=true);
}
  
}

