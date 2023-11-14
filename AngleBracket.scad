module AngleBracket(t=0.1, depth=12, w=2, h=2) {
    points = [
        [0, 0],
        [w, 0],
        [w, t],
        [t, t],
        [t, h],
        [0, h]
    ];
    translate([0, depth/2, 0])
        rotate([90, 0, 0])
            linear_extrude(height=depth, center = true) {
                polygon(points);
        }
}

module AngleBracket2x2(depth=12) {
    // https://www.lowes.com/pd/Hillman-2-in-W-x-2-in-H-x-4-ft-L-Plain-Hot-Rolled-Steel-Solid-Angle/3059247
    t = 0.125;
    AngleBracket(t, depth, 2, 2);
}

module AngleBracket1x1(depth=12) {
    // https://www.lowes.com/pd/Hillman-1-in-W-x-1-in-H-x-3-ft-L-Plain-Hot-Rolled-Steel-Solid-Angle/3057607
    t = 0.125;
    AngleBracket(t, depth, 1, 1);
}

AngleBracket2x2();
AngleBracket1x1(15);