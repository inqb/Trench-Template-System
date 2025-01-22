include <consts.scad>
use <trench_template.scad>
use <utils.scad>

module template_blank(system=system_openlock) {
    template_base(system);
}

module template_U(system=system_openlock) {
    template_indents([0], system);
}

module template_L(system=system_openlock) {
    template_indents([0, 90], system);
}

module template_I(system=system_openlock) {
    template_indents([0, 180], system);
}

module template_T(system=system_openlock) {
    template_indents([0, 90, 180], system);
}

module template_X(system=system_openlock) {
    template_indents([0, 90, 180, 270], system);
}

module template_O(system=system_openlock) {
    edge_offset = (template_width - trench_width) / 2;
    template_polygon([
            [edge_offset, 0],
            [template_width - edge_offset, 0],
            
            [template_width, edge_offset],
            [template_width, template_width - edge_offset],
            
            [template_width - edge_offset, template_width],
            [edge_offset, template_width],

            [0, template_width - edge_offset],
            [0, edge_offset],
        ],
        system,
    );
}

function bastion_points() =
    let(edge_offset = (template_width - trench_width) / 2)
    [
        [edge_offset, 0],
        [template_width - edge_offset, 0],
        
        [template_width, edge_offset],
        [template_width, template_width - edge_offset],
        
        [template_width - edge_offset, template_width],
        [edge_offset, template_width],
    ];

module template_bastion(system=system_openlock) {
    template_polygon(bastion_points(), system);
}

module template_sketch(filename, system=system_openlock) {
    template_base(system)
        center_template()
            import(filename);
}

// 30/60 diagonal trench
function three_by_four_diag() =
    // yeah, I know we could reduce by two, but it'd be harder to read
    let (trench_diag_30_axis_slice_width = trench_width * 2 / sqrt(3))
    let (trench_x_size = 4 * template_width / sqrt(3))
    let (xmax = 3 * template_width)
    let (x0 = (xmax - trench_x_size) / 2)
    let (ymax = 4 * template_width)
    let (x30_1 = template_width / 2 - trench_width / 2)
    let (y30_1 = (x30_1 - (x0 - trench_diag_30_axis_slice_width / 2)) * sqrt(3))
    let (x30_2 = template_width / 2 + trench_width / 2)
    let (y30_2 = (x30_2 - (x0 + trench_diag_30_axis_slice_width / 2)) * sqrt(3))
    let (x30_3 = xmax - x30_1)
    let (y30_3 = ymax - y30_1)
    let (x30_4 = xmax - x30_2)
    let (y30_4 = ymax - y30_2)
    let (y60_1 = template_width / 2 + trench_width / 2)
    let (x60_1 = x0 - trench_diag_30_axis_slice_width / 2 + (y60_1 / sqrt(3)))
    let (y60_2 = template_width / 2 - trench_width / 2)
    let (x60_2 = x0 + trench_diag_30_axis_slice_width / 2 + (y60_2 / sqrt(3)))
    [
        [0, y60_1],
        [0, y60_2],
        [x60_2, y60_2],
        [x30_3, y30_3],
        [x30_3, ymax],
        [x30_4, ymax],
        [x30_4, y30_4],
        [x60_1, y60_1],
    ];

module template_three_by_four_diag(selection, system=system_openlock) {
    template_polygon_grid(three_by_four_diag(), selection, system);
}

// test
p = three_by_four_diag();
selection = [1, 2];
explode_preview(3, 4, 10, p, selection);

