// Units are in mm.

// rest_height: The height of the backrest.
// depth: The distance from the front to the back.
module stand(rest_height = 20, depth = 70)
{
    // Thickness of the device. This is the distance from the front edge to the back. Plus a fudge factor.
    device_thickness = 28 + 1;

    // Angle of the backrest.
    back_angle = 15;

    // Angle of the floor. It could just be equal to back_angle, but it's looks better if it isn't.
    floor_angle = back_angle / 2;

    // The lowest point of the top of the stand.
    min_height = 10;

    // The height of the lip on the front of the stand.
    lip_height = 12;

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

    A = [ 0, 0 ];
    B = [ 0, min_height + floor_y + lip_height ];
    C = [ lip_thickness, min_height + floor_y + lip_height ];
    D = [ lip_thickness, min_height + floor_y ];
    E = [ lip_thickness + floor_x, min_height ];
    F = [ lip_thickness + floor_x + rest_x, min_height + rest_height ];
    G = [ depth, min_height + rest_height ];
    H = [ depth, 0 ];

    union()
    {
        // 1/2mm corner rounding
        offset(1, $fn = 24) offset(-1, $fn = 24)
            // Shape
            polygon([ A, B, C, D, E, F, G, H ]);
        // The little knob at the top of the lip.
        translate(concat(C, 0)) circle(lip_thickness);
    };
}

// width = 135;
// fan = 107;
width = 80;
fan = 60;
proud = (width - fan) / 2;
depth = 65;

// Fudge factor to make sure things glue together correctly.
glue = 0.1;

union()
{
    color("#f84") linear_extrude(proud) stand(31, depth);

    color("#48f") translate([ 0, 0, proud - glue ]) linear_extrude(width + 2 * glue - 2 * proud)
        stand(19, depth); // about the distance from the bottom edge to the fan.

    color("#8f4") translate([ 0, 0, width - proud ]) linear_extrude(proud) stand(31, depth);
}
