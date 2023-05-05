
height = 40;
width = 80;
thick = 3;
back_rest = 18;
device = 28 + 2;
rest_angle = 15;
floor_angle = 8;
depth = thick + cos(floor_angle) * device + sin(rest_angle) * back_rest + device;

solid = [
    [0,0],
    [0,height],
    [thick, height],
    [thick, height - back_rest],
    [device + thick, height - back_rest - tan(floor_angle) * device],
    [device + thick + sin(15) * back_rest , height],
    [depth,height],
    [depth,0]
];

outline = concat(solid, [
    [depth - thick, 0],
    [depth - thick, height - thick],
    [depth - device + 2 * thick, height - thick],
    [depth - device + 2 * thick, height - back_rest - 2 * thick],
    [thick, height - back_rest - 2 * thick],
    [thick, 0],
    ]
);

// Wall
translate([0, 0, width - thick]) linear_extrude(thick) polygon(solid);

linear_extrude(width) polygon(outline);

// Wall
linear_extrude(thick) polygon(solid);
