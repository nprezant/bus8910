use <Round-Anything/polyround.scad>

use <Stacking.scad>
use <BoltHole.scad>
use <HatBracket.scad>

module _BottomHoles(w, margin, dia) {
    BoltHole(margin, margin, dia);
    BoltHole(margin, w-margin, dia);
    BoltHole(w-margin, w-margin, dia);
    BoltHole(w-margin, margin, dia);
}

module _BottomPlate(w, t, r) {
    points = [[0,0,r], [0,w,r], [w,w,r], [w,0,r]];
    
    linear_extrude(t)
        polygon(polyRound(points, 30));
}

module _Bottom() {
    // Main
    w = 9.125;
    t = 0.125;
    roundedness = 0.75;
    
    // Holes
    margin = 1.125;
    dia = 0.75;
    
    // Centering
    trans = [-w/2, -w/2, 0];
    
    translate(trans)
    difference() {
        _BottomPlate(w, t, roundedness);
        _BottomHoles(w, margin, dia/2);
    }
}

module _Middle(h) {
    sizes = [ [2, h+0.2], [1.25, 0.0675], [0.5, 0.0675], [0.375, 0.375], [0.375, 0.375] ];
    StackedCylinders(sizes, $fn=64);
}

module _Top(z) {
    wFlange = 3;
    wCrown = 6.75;
    angle = 90;
    h = 0.75;
    t = 0.125;
    depth = 13.75;
    rounding = 0;
    
    // Line up front edge with front edge of bottom plate
    wTotal = getHatWidth(wFlange, wCrown, angle, h);
    trans = [-wTotal/2, -5, z];
    
    translate(trans)
    HatBracket(wFlange, wCrown, angle, h, t, depth, rounding);
}

module SwivelBase() {
    _Bottom();
    
    h = 3; // Pedastal height
    
    _Middle(h=3);
    
    _Top(z=3);
}

SwivelBase();