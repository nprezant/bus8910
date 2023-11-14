module BoxBracket(t=0.1, depth=12, w=2, h=2) {
    points = [
        [0, 0],
        [w, 0],
        [w, h],
        [0, h]
    ];
    translate([0, depth/2, 0])
        rotate([90, 0, 0])
            linear_extrude(height=depth, center = true)
                difference() {
                    polygon(points);
                    offset(-t)
                        polygon(points);
                }
}

module BoxBracketHalfxHalf(depth=12) {
    t = 0.063;
    BoxBracket(t, depth, 0.5, 0.5);
}

module BoxBracket1x1(depth=12) {
    t = 0.064;
    BoxBracket(t, depth, 1, 1);
}

%BoxBracket1x1();
BoxBracketHalfxHalf();