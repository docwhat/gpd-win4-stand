// Units are in mm.

use <scad-utils/morphology.scad>;

width = 90; // x-axis: -left, +right
depth = 65; // y-axis: -closer, +away
height = 31; // z-axis: -down, +up
seat_height = 9; // The height of the lowest point of the seat.

strut_thickness = 1;
seat_thickness = 1;

module profile(height, below_floor = 0) {
    // Thickness of the device. This is the distance from the front edge to the back. Plus a fudge factor.
    device_thickness = 28 + 1;

    // Angle of the backrest.
    back_angle = 15;

    // Angle of the floor. It could just be equal to back_angle, but it's looks better if it isn't.
    floor_angle = back_angle / 2;

    // The vertical distance from the min_height to point d. The
    // height added because the floor tilts back.
    floor_y = sin(floor_angle) * device_thickness;

    // The horizontal distance from point d to point e.
    floor_x = cos(floor_angle) * device_thickness;

    // The horizontal distance from point e to point f.
    rest_x = tan(back_angle) * height;

    //  y
    //  |
    //  +--x
    //
    //        /----|               d----e
    //       /     |              /     |
    //   ___/      |         b---c      |
    //  |          |         |          |
    //  +----------+         a----------f

    // We go one seat_thickness too low on purpose so we
    // can cut it off.

    A = [ 0, -below_floor ];
    B = [ 0, seat_height + floor_y ];
    C = [ floor_x, seat_height ];
    D = [ floor_x + rest_x, seat_height + height ];
    E = [ depth, seat_height + height ];
    F = [ depth, -below_floor ];

    // rounding()
    polygon([ A, B, C, D, E, F ]);
}

// rest_height: The height of the backrest.
// depth: The distance from the front to the back.
// min_height:: The lowest point of the top of the stand.
module stand(rest_height = 20, depth = 70, min_height = 2, shell_r = 0) {
    // Thickness of the device. This is the distance from the front edge to the back. Plus a fudge factor.
    device_thickness = 28 + 1;

    // Angle of the backrest.
    back_angle = 15;

    // Angle of the floor. It could just be equal to back_angle, but it's looks better if it isn't.
    floor_angle = back_angle / 2;

    // The height of the lip on the front of the stand.
    lip_height = 20;

    // The thickness of the lip on the front of the stand.
    // i.e., the horizontal distance from b to c
    lip_thickness = 2.5;

    // The vertical distance from the min_height to point d. The
    // height added because the floor tilts back.
    floor_y = sin(floor_angle) * device_thickness;

    // The horizontal distance from point d to point e.
    floor_x = cos(floor_angle) * device_thickness;

    // The horizontal distance from point e to point f.
    rest_x = tan(back_angle) * rest_height;

    //  y
    //        /----|               f    g
    //  |    /     |        bc
    //  |___/      |         d   e
    //  L__________|  x     a           h

    A = [ 0, -1 ];
    B = [ 0, min_height + floor_y + lip_height ];
    C = [ lip_thickness, min_height + floor_y + lip_height ];
    D = [ lip_thickness, min_height + floor_y ];
    E = [ lip_thickness + floor_x, min_height ];
    F = [ lip_thickness + floor_x + rest_x, min_height + rest_height ];
    G = [ depth, min_height + rest_height ];
    H = [ depth, -1 ];

polygon([ A, B, C, D, E, F, G, H ]);
//    difference()
//    {
//        union()
//        {
//            rounding()
//            difference() {
//                shell(shell_r)
//                polygon([ A, B, C, D, E, F, G, H ]);

//                polygon([
//                    [abs(shell_r), -2],
//                    [abs(shell_r), abs(shell_r)],
//                    [depth - abs(shell_r), abs(shell_r)],
//                    [depth - abs(shell_r), -2]
//                ]);
//            }
//            // The little knob at the top of the lip.
//            translate(concat(C, 0))
//                circle(lip_thickness);
//        };
//        polygon([ [ 0, -4 ], [ 0, 0 ], [ depth, 0 ], [ depth, -4 ] ]);
//    }
}


module whole_thing(depth, width, height) {
    // height of the fins above the back rest.
    proud = 12;


    // Distance from the ground to the lowest
    min_height = 2;

    union() {
        // Green Strut
        color("#8f4")
        translate([ 0, 0, width - strut_thickness ])
        linear_extrude(strut_thickness)
        profile(height);

        // Red Strut
        color("#f48")
        translate([ 0, 0, 2 * width / 3 ])
        linear_extrude(strut_thickness)
        profile(height);

        // Purple Strut
        color("#84f")
        translate([ 0, 0, width / 3 ])
        linear_extrude(strut_thickness)
        profile(height);

        // Orange Strut
        color("#f84")
        translate([ 0, 0, 0 ])
        linear_extrude(strut_thickness)
        profile(height);

        // Blue Back and Seat
        color("#48f")
        linear_extrude(width)
        difference() {
            shell(seat_thickness)
            profile(height - proud, seat_thickness);

            polygon([
                [ -seat_thickness, 0 ],
                [ depth + seat_thickness, 0 ],
                [ depth + seat_thickness, -4 ],
                [ -seat_thickness, -4 ]
            ]);
        };
    };
}


translate([
    (-1 * width / 2),
    (-1 * depth / 2),
    0])
rotate([90, 0, 90])
whole_thing(depth = 65, width = 90, height = 31);

// EOF
