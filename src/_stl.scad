include <consts.scad>
use <lib.scad>
use <utils.scad>

// use the jig to press fit magnets keeping consistent polarity
//openlock_port_magnet_jig();

// blank template
//template_blank(); //same as template_blank(system_openlock);

// blank template with sparse openlock slots placement
// not OpenLOCK compliant, but offers better clip grip and easier non-magnetic clips alignment
//template_blank(system_openlock_sparse);

// a bunch of pre-defined center-interface templates
//template_I(system_openlock_sparse);
//template_L(system_openlock_sparse);
//template_T(system_openlock_sparse);
//template_X(system_openlock_sparse);
//template_U(system_openlock_sparse);

//template_O(system_openlock_sparse);

// not really a bastion, but kinda close
//template_bastion(system_openlock_sparse);

// 3x4 30° diagonal trench
// 90° connectors are interchangeable, so printing both of them twice will give you some flexibility
//template_three_by_four_diag([0, 0], system_openlock_sparse); // interchangeable with [2, 3]

//template_three_by_four_diag([0, 1], system_openlock_sparse);
//template_three_by_four_diag([1, 0], system_openlock_sparse);
//template_three_by_four_diag([1, 1], system_openlock_sparse);

//template_three_by_four_diag([1, 2], system_openlock_sparse); // same as [1, 1]
//template_three_by_four_diag([1, 3], system_openlock_sparse); // same as [1, 0]
//template_three_by_four_diag([2, 2], system_openlock_sparse); // same as [0, 1]

//template_three_by_four_diag([2, 3], system_openlock_sparse); // interchangeable with [0, 0]

template_sketch("../sketches/45-BodySketch.dxf", system_openlock_sparse);

// TODO: diagonal cross-sections?
