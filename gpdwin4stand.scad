// Units are in mm.

module stand(rest_height = 20) {
// Depth of the device. This is the distance from the front edge of the device to the back. Plus a fudge factor.
device = 28 + 2;

// Angle of the backrest.
rest_angle = 30;

// Angle of the floor. It could just be equal to rest_angle, but it's looks better if it isn't.
// floor_angle = 8;
floor_angle = rest_angle / 2;

// The distance from the front to the back.
depth = 74;

// The lowest point of the top of the stand.
min_height = 10;

// The height of the lip on the front of the stand.
lip_height = 10;

// The thickness of the lip on the front of the stand.
lip_thickness = 2;

// // The height of the backrest.
// rest_height = 20;

//  y
//        /----|               f    g
//  |    /     |        bc
//  |___/      |        d   e
//  L__________|  x     a           h

floor_y = sin(floor_angle) * device;
floor_x = cos(floor_angle) * device;
rest_x = tan(rest_angle) * rest_height;

A = [0,                                0];
B = [0,                                min_height + floor_y + lip_height];
C = [lip_thickness,                    min_height + floor_y + lip_height];
D = [lip_thickness,                    min_height + floor_y];
E = [lip_thickness + floor_x,          min_height];
F = [lip_thickness + floor_x + rest_x, min_height + rest_height];
G = [depth,                            min_height + rest_height];
H = [depth,                            0];

    union() {
        polygon([A,B,C,D,E,F,G,H]);
        translate(concat(C, 0)) circle(lip_thickness);
    };
}

width = 137;
fan = 107;
proud = (width - fan) / 2;


linear_extrude(proud) stand(31);
linear_extrude(width) stand(19); // about the distance from the bottom edge to the fan.
translate([0,0,width - proud]) linear_extrude(proud) stand(31);
