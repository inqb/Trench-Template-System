include <consts.scad>
use <trench_template.scad>
use <openlock_port.scad>

module explode_geometry(x, y, trench_definition) {
    // offset hack - adds tolerance for preview/render
    eps = 0.01;
    eps_half = eps / 2;
    // copy pasted `template_base`'s code to get rid of openlock system - simplifies geometry *a lot*
    difference() {
        translate([
            -template_width_mm / 2 + eps_half,
            -template_width_mm / 2 + eps_half,
            eps_half
        ])
            cube([
                template_width_mm - eps,
                template_width_mm - eps,
                trench_height_mm + openlock_edge_extrude_mm - eps
            ]);
        
        translate([0, 0, openlock_edge_extrude_mm])
            linear_extrude(trench_height_mm)
                center_polygon_grid(trench_definition, [x, y]);
    }
}

module explode_preview(group_width, group_height, explode_gap_mm, trench_definition, selection) {
    group_width_half = group_width / 2;
    group_height_half = group_height / 2;
    for(iter_y = [1 : 1 : group_height]) {
        for(iter_x = [1 : 1 : group_width]) {
            x = iter_x - 1;
            y = iter_y - 1;
            gap_offset_x = ((x + 0.5 - group_width_half) / 2) * explode_gap_mm;
            gap_offset_y = ((y + 0.5 - group_width_half) / 2) * explode_gap_mm;
            translate([
                template_width_mm * (x - group_width_half + 0.5) + gap_offset_x,
                template_width_mm * (y - group_height_half + 0.5) + gap_offset_y,
                0
            ]) {
                if(selection[0] == x && selection[1] == y)
                    #explode_geometry(x, y, trench_definition);
                else
                    explode_geometry(x, y, trench_definition);
            }
        }
    }
}

// TODO: get rid of magic numbers
module openlock_port_magnet_jig() {
    difference() {
        eps = 0.01;
        box_size = 16;
        translate([eps, -box_size / 2, 0])
            cube([box_size, box_size, trench_height_mm + openlock_edge_extrude_mm]);
        translate([0, 0, openlock_edge_extrude_mid_mm])
            port();
    }
}

// test
trench_definition_test = [
    [5.5, 5.5],
    [5.5, 6.5],
    [6.5, 6.5],
    [6.5, 5.5],
];

//template_polygon_grid(trench_definition_test, [0, 0]);
explode_preview(2, 2, 10, trench_definition_test, [0, 0]);

//openlock_port_magnet_jig();
