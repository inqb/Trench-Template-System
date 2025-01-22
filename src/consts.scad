mm_in_inch = 25.399999619;

function inches_to_mm(inches) = mm_in_inch * inches;
function mm_to_inches(mm) = mm / mm_in_inch;

// yeah... units are in inches, unless suffixed with `_mm`...
trench_width = 2.5;
template_width = 6;

trench_height_mm = 40;

template_width_mm = inches_to_mm(template_width);

// measured some of the official terrain, but not all of them - might need to adjust it...
30_deg_in_width_mm = 17;
30_deg_out_width_mm = 15.20;
60_deg_in_width_mm = 18.10;
60_deg_out_width_mm = 27.10;

openlock_edge_extrude_mm = 7;
openlock_edge_extrude_mid_mm = openlock_edge_extrude_mm / 2;

system_openlock = "openlock";
system_openlock_sparse = "openlock_sparse";
