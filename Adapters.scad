use <SwivelBase.scad>
use <AngleBracket.scad>
use <BoxBracket.scad>
use <SuspensionBox.scad>

module PlacedAngleBracket(depth=12, zrot=0, outsideEdge=0, faceup=true, isBig=false) {
    yrot = faceup ? 0 : 90;
    size = isBig ? 2 : 1;
    offset = outsideEdge < 0 ? outsideEdge + size/2 : outsideEdge - size/2;
    
    xtrans = zrot == 180 || zrot == 0 ? offset : 0;
    ytrans = zrot == 180 || zrot == 0 ? 0      : offset;
    
    translate([xtrans,ytrans,0])
    rotate([0, yrot, zrot])
    if (!isBig) {
        AngleBracket1x1(depth=depth);
    } else {
        AngleBracket2x2(depth=depth);
    }
}

module PlacedBoxBracket(depth=12, zrot=0, outsideEdge=0) {
    size = 1;
    offset = outsideEdge < 0 ? outsideEdge + size/2 : outsideEdge - size/2;

    xtrans = zrot == 180 || zrot == 0 ? offset : 0;
    ytrans = zrot == 180 || zrot == 0 ? 0      : offset;
    
    translate([xtrans,ytrans,0])
    rotate([0, 0, zrot])
    BoxBracket1x1(depth);
}

module BottomAdapter() {
    
    wLower = 12.5; // Width of the lower attachments
    depth = 13.5; // Depth of the lower attachments
    wUpper = 9.25; // Width of the upper attachments
    
    PlacedAngleBracket(depth=wLower, zrot=90, outsideEdge=-wUpper/2, faceup=true);
    PlacedAngleBracket(depth=wLower, zrot=-90, outsideEdge=wUpper/2, faceup=true);
    
    PlacedAngleBracket(depth=depth, zrot=0, outsideEdge=-wLower/2, faceup=true);
    PlacedAngleBracket(depth=depth, zrot=180, outsideEdge=wLower/2, faceup=true);
}

module TopAdapter() {
    
    dLower = 9; // Depth of the lower attachments
    wUpper = 12; // Width of the upper attachments
    dUpper = 14; // Depth of the upper attachments
    
    translate([0,1,0]) {
        PlacedBoxBracket(depth=wUpper, zrot=90, outsideEdge=-dLower/2);
        PlacedBoxBracket(depth=wUpper, zrot=-90, outsideEdge=dLower/2);
    }
    
    translate([0,2,0]) {
        PlacedAngleBracket(depth=dUpper, zrot=0, outsideEdge=-wUpper/2, faceup=false);
        PlacedAngleBracket(depth=dUpper, zrot=180, outsideEdge=wUpper/2, faceup=false);
        translate([0,0,1]) {
            PlacedBoxBracket(depth=dUpper, zrot=0, outsideEdge=-wUpper/2);
            PlacedBoxBracket(depth=dUpper, zrot=180, outsideEdge=wUpper/2);
        }
    }
}

color("skyblue", 0.4)
translate([0,0,-1])
BottomAdapter();

color("gray", 0.8)
translate([0,0,0.125])
SwivelBase();

color("skyblue", 0.4)
translate([0,0,5])
TopAdapter();

color("gray", 0.8)
translate([0, 0, 8])
rotate([180, 0, 0])
SuspensionBox();
