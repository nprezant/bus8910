use <Round-Anything/polyround.scad>

function getHatWidth(wFlangeBoth, wCrown, angle, h) =
    let (wAngle = h/tan(angle))
    wFlangeBoth + wCrown + wAngle;

// Bracket
module HatBracket(w_flange_both, w_crown, angle, h, t, depth, r = 0.25) {
    
    w_total = getHatWidth(w_flange_both, w_crown, angle, h);
    echo(w_total);
    w_flange = 0.5 * w_flange_both;

    x_flange1_start = 0;
    x_flange1_end = w_flange;
    x_flange2_start = w_total - w_flange;
    x_flange2_end = w_total;

    y_flange_inner = 0;
    y_flange_outer = t;
    y_crown_inner = h - t;
    y_crown_outer = h;

    x_crown_start = w_total/2 - w_crown/2;
    x_crown_end = x_crown_start + w_crown;

    // Try not to distort the angles too much.
    //soh cah toa
    
    angle_factor = t;

    points = [
        [x_flange1_start, y_flange_inner, r],
        [x_flange1_start, y_flange_outer, r],
        [x_flange1_end, y_flange_outer, r],
        [x_crown_start, y_crown_outer, r],
        [x_crown_end, y_crown_outer, r],
        [x_flange2_start, y_flange_outer, r],
        [x_flange2_end, y_flange_outer, r],
        [x_flange2_end, y_flange_inner, r],
        [x_flange2_start - angle_factor, y_flange_inner, r],
        [x_crown_end - angle_factor, y_crown_inner, r],
        [x_crown_start + angle_factor, y_crown_inner, r],
        [x_flange1_end + angle_factor, y_flange_inner, r],
    ];

    translate([0, depth/2, h]) {
        rotate([-90, 0, 0]) {
            linear_extrude(height=depth, center=true, convexity=10, twist=0) {
                polygon(polyRound(points, 30));
            }
        }
    }
}

// Bolt holes
module bolt_cylinder(dia=0.2) {
    cylinder(r=dia, h=10, center=true, $fn=16);
}

// Takes a thing and patterns it in a square
module square_pattern(x_origin, y_origin, side_len) {
    for (x=[x_origin, x_origin + side_len]) {
        for (y=[y_origin, y_origin + side_len]) {
            translate([x, y, 0]) {
                children(0);
            }
        }
    }
}

// Assembly
module bracket(seat_bolt_dist, base_bolt_dist, t, h, padding, dia, center = false) {

    w_flange = padding * 2;
    w_crown = base_bolt_dist + padding * 2;
    angle = 90;
    w_total = getHatWidth(w_flange * 2, w_crown, angle, h);
    rounding = 0;

    transXY = center ? -w_total/2 : 0;
    transZ = center ? h/2 : 0;

    translate([transXY, transXY, transZ]) {
        difference() {
            HatBracket(w_flange*2, w_crown, angle, h, t, w_total, rounding);
            square_pattern(padding, padding, seat_bolt_dist) {
                bolt_cylinder(dia);
            }
            crown_bolt_offset = (w_total - w_crown) / 2 + padding;
            square_pattern(crown_bolt_offset, crown_bolt_offset, base_bolt_dist) {
                bolt_cylinder(dia);
            }
        }
    }
}

// seat square side length (in)
seat_bolt_dist = 11;

// swivel base square side length (in)
base_bolt_dist = 7;

// Sheet thickness (in)
t = 0.20;

// Total height (in)
h = 1.5;

// Minimum padding around bolt holes (in)
padding = 0.75;

// Bolt stuff
dia = 0.3;

bracket(seat_bolt_dist, base_bolt_dist, t, h, padding, dia, center=false);

