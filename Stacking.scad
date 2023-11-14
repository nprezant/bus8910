
// https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Tips_and_Tricks#Stack_cylinders_on_top_of_each_other
// One option to solve this is by using a recursive module
// that creates a new translated coordinate system before
// going into the next level.
module StackedCylinders(size_vector, idx = 0) {
    if (idx < len(size_vector)) {
        radius = size_vector[idx][0];
        height = size_vector[idx][1];

        // Create the cylinder for the current level.
        cylinder(r = radius, h = height);

        // Recursive call generating the next cylinders
        // translated in Z direction based on the height
        // of the current cylinder
        translate([0, 0, height]) {
            StackedCylinders(size_vector, idx + 1);
        }
    }
}

// Define the sizes for the cylinders, first value is the
// radius, the second is the height.
// All cylinders are to be stacked above each other (with
// an additional spacing of 1 unit).
sizes = [ [ 26, 3 ], [ 20, 5 ], [ 11, 8 ],  [ 5, 10 ], [ 2, 13 ] ];

// Call the module to create the stacked cylinders.
StackedCylinders(sizes);