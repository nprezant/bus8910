 // Arrange its children in a regular rectangular array
 //      spacing - the space between children origins
 //      n       - the number of children along x axis
 module Arrange(spacing=50, n=5) {
    nparts = $children;
    for(i=[0:1:n-1], j=[0:nparts/n])
        if (i+n*j < nparts)
            translate([spacing*(i+1), spacing*j, 0]) 
                children(i+n*j);
 }

 Arrange(spacing=50,n=3) {
    sphere(r=20,$fn=8);
    sphere(r=20,$fn=10);
    cube(30,center=true);
    sphere(r=20,$fn=14);
    sphere(r=20,$fn=16);
    sphere(r=20,$fn=18);
    cylinder(r=15,h=30);
    sphere(r=20,$fn=22);
 }