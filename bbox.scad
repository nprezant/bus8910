module bbox() { 

    // a 3D approx. of the children projection on X axis 
    module xProjection() 
        translate([0,1/2,-1/2]) 
            linear_extrude(1) 
                hull() 
                    projection() 
                        rotate([90,0,0]) 
                            linear_extrude(1) 
                                projection() children(); 
  
    // a bounding box with an offset of 1 in all axis
    module bbx()  
        minkowski() { 
            xProjection() children(); // x axis
            rotate(-90)               // y axis
                xProjection() rotate(90) children(); 
            rotate([0,-90,0])         // z axis
                xProjection() rotate([0,90,0]) children(); 
        } 
    
    // offset children() (a cube) by -1 in all axis
    module shrink()
      intersection() {
        translate([ 1, 1, 1]) children();
        translate([-1,-1,-1]) children();
      }

   shrink() bbx() children(); 
}

module model()
  color("red") 
  union() {
    sphere(10);
    translate([15,10,5]) cube(10);
  }

model();
%bbox() model();

module textthingexample() {
  my_string = "Demo text";

module BasePlate(margin) {
  minkowski() {
    translate(-margin) square(2*margin);
    projection() bbox() linear_extrude(1) children();
  }
}

module TextThing() {
  text(my_string, halign="center", valign="center");
}


hole_size = 3;
margwidth = 2;
linear_extrude(1)
  difference() {
    BasePlate([2*(hole_size+margwidth), margwidth]) TextThing();
    offset(hole_size) {
      difference() {
        scale([1.001, 1])
          resize([-1, 0.001])
          BasePlate([hole_size+margwidth, margwidth]) TextThing();
        BasePlate([hole_size+margwidth, margwidth]) TextThing();
      }
    }
  }

linear_extrude(2) TextThing();
}

translate([0, -30, 0])
textthingexample();
