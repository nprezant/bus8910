
module SuspensionBox() {
  w = 12.5; // width
  d = 14.5; // depth

  iw = 6.5; // inner width
  id = 9; // inner depth

  // base plate
  difference() {
    cube(size=[w, d, 0.125], center=true);
    translate([0, -0.75, 0]) {
      cube(size=[iw, id, 2], center=true);
    }
  }

  // box beam support
  translate([0, 5.5, 0.5]) {
    cube(size=[1, 3.5, 1], center=true);
  }

  // flange
  translate([0, 3.75, 0.5]) {
    cube(size=[iw, 0.125, 1], center=true);
  }

  // eye hook
  translate([0, 3.25, 0.5]) {
    difference() {
      union() {
        rotate([0, 90, 0]) {
          cylinder(r=0.35, h=0.125, $fn=64, center=true);
        }
        translate([0, 1, 0]) {
          cube(size=[0.125, 2, 0.7], center=true);
        }
      }
      rotate([0, 90, 0]) {
        cylinder(r=0.15, h=2, $fn=64, center=true);
      }
    }
  }

  // Dampener
  translate([0, 1.2, -0.7]) {
    rotate([-60, 0, 0]) {
      cylinder(r=0.3, h=4, center=true, $fn=30);
    }
  }

  // rear support thing
  translate([0, -6.25, 0.25]) {
    cube(size=[iw, 2, 0.5], center=true);
  }
}

SuspensionBox();