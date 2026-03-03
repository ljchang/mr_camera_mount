// ============================================================
// threads.scad — Thread profiles for 3D-printed plastic parts
//
// For best results print with 0.15 mm layers or finer.
// Internal threads may benefit from chasing with a real tap.
// ============================================================

// Create an external (male) metric thread.
//   d     = nominal diameter (e.g. 4 for M4)
//   pitch = thread pitch in mm
//   h     = thread length
//   tol   = clearance (positive = smaller thread for easier fit)
module metric_thread(d, pitch, h, tol = 0) {
    tooth_h = pitch * 0.5;  // simplified depth for printability
    r_crest = d / 2 - tol;
    r_root  = r_crest - tooth_h;

    turns  = ceil(h / pitch);
    steps  = max(36, $fn);
    step_a = 360 / steps;
    dz     = pitch / steps;

    // Core shaft
    cylinder(r = r_root, h = h);

    // Helical thread ridge
    for (t = [0 : turns - 1]) {
        for (s = [0 : steps - 1]) {
            z0 = t * pitch + s * dz;
            z1 = z0 + dz;
            if (z0 < h) {
                a0 = s * step_a;
                a1 = a0 + step_a;
                hull() {
                    translate([0, 0, z0])
                        rotate([0, 0, a0])
                            translate([r_crest, 0, 0])
                                cylinder(r = tooth_h, h = 0.01, $fn = 4);
                    translate([0, 0, z1])
                        rotate([0, 0, a1])
                            translate([r_crest, 0, 0])
                                cylinder(r = tooth_h, h = 0.01, $fn = 4);
                }
            }
        }
    }
}

// Create a threaded hole (female / internal thread).
// Used inside a difference() — this module produces the shape to subtract.
//   d     = nominal screw diameter
//   pitch = thread pitch
//   h     = depth of hole
//   tol   = clearance
module threaded_hole(d, pitch, h, tol = 0.2) {
    tooth_h = pitch * 0.5;  // matches male thread depth
    d_core  = d - tooth_h * 2 + tol;  // minor bore (thread ridges protrude from here)
    r_groove = d / 2 + tol;           // centre of helical groove in wall

    // Core bore at minor diameter
    cylinder(d = d_core, h = h);

    // Helical groove extending outward from core bore into surrounding wall.
    // Material left between grooves = internal thread ridges.
    turns  = ceil(h / pitch);
    steps  = max(36, $fn);
    step_a = 360 / steps;
    dz     = pitch / steps;

    for (t = [0 : turns - 1]) {
        for (s = [0 : steps - 1]) {
            z0 = t * pitch + s * dz;
            z1 = z0 + dz;
            if (z0 < h) {
                a0 = s * step_a;
                a1 = a0 + step_a;
                hull() {
                    translate([0, 0, z0])
                        rotate([0, 0, a0])
                            translate([r_groove, 0, 0])
                                cylinder(r = tooth_h, h = 0.01, $fn = 4);
                    translate([0, 0, z1])
                        rotate([0, 0, a1])
                            translate([r_groove, 0, 0])
                                cylinder(r = tooth_h, h = 0.01, $fn = 4);
                }
            }
        }
    }
}
