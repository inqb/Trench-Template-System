include <consts.scad>
use <openlock_port.scad>

module template_base(system=system_openlock) {
    difference() {
        if(system==system_openlock)
            openlock_square(template_width, trench_height_mm);
        if(system==system_openlock_sparse)
            openlock_square(template_width, trench_height_mm, true);
        
        translate([0, 0, openlock_edge_extrude_mm])
            linear_extrude(trench_height_mm)
                children();
    }
}

module center_template() {
    template_width_half_mm = template_width_mm / 2;
    
    translate([-template_width_half_mm, -template_width_half_mm, 0])
        children();
}

module center_polygon(points) {
    center_template()
        polygon(points * mm_in_inch);
}

module center_polygon_grid(points, coords) {
    translate([
        -coords[0] * template_width_mm,
        -coords[1] * template_width_mm
    ])
        center_polygon(points);
}

module template_polygon_grid(points, coords, system=system_openlock) {
    template_base(system)
        center_polygon_grid(points, coords);
}

module template_polygon(points, system) {
    template_polygon_grid(points, [0, 0], system);
}

module indent() {
    edge_offset = (template_width - trench_width) / 2;
    
    center_polygon([
        [edge_offset, 0],
        [template_width - edge_offset, 0],
        [template_width - edge_offset, template_width - edge_offset],
        [edge_offset, template_width - edge_offset],
    ]);
}

module template_indents(angles, system=system_openlock) {
    template_base(system)
        for(angle = angles)
            rotate(angle)
                indent();
}

// test
template_base();
