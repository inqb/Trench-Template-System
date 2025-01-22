include <consts.scad>

module port() {
    // all units are in mm (yes, this is a *special* case for this project)
    depth = 4;
    width = 9.75;
    collar_width = 1.8545;
    collar_indent = 1;
    height = 13.2;
    notch_width = 5.8445;
    notch_height = 9.80;
    notch_offset = (height - notch_height) / 2;
    notch_rest = 1;
    // offset hack - adds tolerance for preview/render
    eps = 0.01;
    eps_half = eps / 2;
    
    translate([0, -height / 2, -depth / 2])
        difference() {
            translate([0, eps_half, eps_half])
                cube([width, height - eps, depth - eps]);
            linear_extrude(depth)
                polygon([
                    [collar_width, 0],
                    [collar_width, collar_indent],
                    [notch_width - notch_rest, notch_offset],
                    [notch_width, notch_offset],
                    [notch_width, 0]
                ]);
            linear_extrude(depth)
                polygon([
                    [collar_width, height],
                    [collar_width, height - collar_indent],
                    [notch_width - notch_rest, height - notch_offset],
                    [notch_width, height - notch_offset],
                    [notch_width, height]
                ]);
        }
}

// yeah... units are in inches, unless suffixed with `_mm`...
module openlock_rectangle(width, height, extrude_mm, sparse=false) {
    width_mm = inches_to_mm(width);
    height_mm = inches_to_mm(height);
    full_inch_mm = inches_to_mm(1);
    half_inch_mm = inches_to_mm(0.5);
    spacing = sparse ? full_inch_mm : half_inch_mm;
    // offset hack - adds tolerance for preview/render
    eps = 0.01;
    eps_half = eps / 2;

    difference() {
        translate([-width_mm / 2 + eps_half, -height_mm / 2 + eps_half, 0]) {
            cube([
                width_mm - eps,
                height_mm - eps,
                openlock_edge_extrude_mm + extrude_mm - eps
            ]);
        }

        // x
        for(angle = [90, 270]) {
            for(offset = [spacing : spacing: width_mm - half_inch_mm]) {
                rotate(angle)
                translate([-height_mm / 2, -width_mm / 2 + offset, openlock_edge_extrude_mid_mm]) {
                    port();
                }
            }
        }
        
        // y
        for(angle = [0, 180]) {
            for(offset = [spacing : spacing : height_mm - half_inch_mm]) {
                rotate(angle)
                translate([-width_mm / 2, -height_mm / 2 + offset, openlock_edge_extrude_mid_mm]) {
                    port();
                }
            }
        }
    }
}

module openlock_square(width, extrude_mm, sparse=false) {
    openlock_rectangle(width, width, extrude_mm, sparse);
}

// test
//port();
