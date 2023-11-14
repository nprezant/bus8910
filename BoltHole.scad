module BoltHole(x=0, y=0, r=0.25) {
    translate([x, y, 0])
        cylinder(r=r, h=100, center=true, $fn=16);
}

BoltHole();