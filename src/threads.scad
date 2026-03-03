// ============================================================
// threads.scad — Simple thread profile for plastic set-screws
//
// Generates a helical thread suitable for 3D-printed parts.
// For best results print with 0.15 mm layers or finer.
// ============================================================

// Create an external (male) metric thread.
//   d     = nominal diameter (e.g. 4 for M4)
//   pitch = thread pitch in mm
//   h     = thread height / length
//   tol   = extra clearance (positive = looser)
module metric_thread(d, pitch, h, tol = 0) {
    // Thread tooth depth (60° metric profile)
    tooth_h = pitch * cos(30);  // ~0.866 * pitch
    r_major = d / 2 + tol;
    r_minor = r_major - tooth_h;

    turns   = ceil(h / pitch);
    steps   = max(48, $fn);
    step_a  = 360 / steps;
    dz      = pitch / steps;

    union() {
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
                                translate([r_minor, 0, 0])
                                    cylinder(r = tooth_h, h = 0.01, $fn = 4);
                        translate([0, 0, z1])
                            rotate([0, 0, a1])
                                translate([r_minor, 0, 0])
                                    cylinder(r = tooth_h, h = 0.01, $fn = 4);
                    }
                }
            }
        }
    }
}

// Create a threaded hole (female / internal thread) by subtracting
// a slightly oversized male thread from the parent body.
//   d     = nominal screw diameter
//   pitch = thread pitch
//   h     = depth of hole
//   tol   = clearance (default adds 0.2 mm for plastic)
module threaded_hole(d, pitch, h, tol = 0.2) {
    // Core cylinder
    cylinder(d = d + tol * 2, h = h);
    // Thread grooves (slightly larger to cut into plastic)
    metric_thread(d, pitch, h, tol);
}
