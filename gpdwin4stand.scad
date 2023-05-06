// Units are in mm.

use <scad-utils/morphology.scad>;

// rest_height: The height of the backrest.
// depth: The distance from the front to the back.
// min_height:: The lowest point of the top of the stand.
module stand(rest_height = 20, depth = 70, min_height = 2, shell_r = 0)
{
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
    lip_thickness = 3;

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

    difference()
    {
        union()
        {
            rounding() difference()
            {
                shell(shell_r) polygon([ A, B, C, D, E, F, G, H ]);
                polygon([[abs(shell_r), -2], [abs(shell_r), abs(shell_r)], [depth - abs(shell_r), abs(shell_r)],
                         [depth - abs(shell_r), -2]]);
            }
            // The little knob at the top of the lip.
            translate(concat(C, 0)) circle(lip_thickness);
        };
        polygon([ [ 0, -4 ], [ 0, 0 ], [ depth, 0 ], [ depth, -4 ] ]);
    }
}

$fn = 24;

width = 90;
depth = 65;

height = 31;
proud = 12;

// The thickness of the walls.
wall = 2.2;
strut_r = 0;
min_height = wall * 6;

// Fudge factor to make sure things glue together correctly.
glue = 0.1;

union()
{
    // Struts
    color("#f84") translate([ 0, 0, 0 ]) linear_extrude(wall)
        stand(rest_height = height, depth = depth, min_height = min_height, shell_r = strut_r);

    color("#84f") translate([ 0, 0, width / 3 ]) linear_extrude(wall)
        stand(rest_height = height, depth = depth, min_height = min_height, shell_r = strut_r);
    color("#f48") translate([ 0, 0, 2 * width / 3 ]) linear_extrude(wall)
        stand(rest_height = height, depth = depth, min_height = min_height, shell_r = strut_r);
    color("#8f4") translate([ 0, 0, width - wall ]) linear_extrude(wall)
        stand(rest_height = height, depth = depth, min_height = min_height, shell_r = strut_r);

    // Back
    color("#48f") translate([ 0, 0, wall - glue ]) linear_extrude(width + 2 * glue - 2 * wall)
        stand(rest_height = height - proud, depth = depth, min_height = min_height,
              shell_r = -1 * wall); // about the distance from the bottom edge to the fan.
}
