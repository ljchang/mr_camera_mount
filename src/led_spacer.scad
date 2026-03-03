// ============================================================
// led_spacer.scad — MR-Compatible IR LED Spacer Mount
//
// Cylinder slides onto the MRC Systems bar (bar axis = Z).
// A rectangular tab extends from the cylinder surface in +X,
// overlapping slightly for a solid one-piece union.
// The LED bore runs horizontally along Y (aligned with the
// cylinder width). A threaded set-screw enters from the outer
// face (+X) and presses inward against the LED.
//
// Coordinate system:
//   Z = bar / cylinder axis
//   Y = LED bore axis (aligned with cylinder width)
//   X = tab extends toward +X; screw enters from +X face
// ============================================================

include <parameters.scad>
include <threads.scad>

// ----------------------------------------------------------
// Main body: cylinder + rectangular tab (one solid piece)
// ----------------------------------------------------------
module spacer_body() {
    union() {
        // --- Main cylinder (solid) ---
        cylinder(d = spacer_od, h = spacer_height);

        // --- Rectangular tab ---
        // Overlaps into cylinder for a solid joint.
        // Centred on cylinder in Y and Z.
        translate([tab_start_x, -tab_width_y / 2, tab_z_offset])
            cube([tab_width_x, tab_width_y, tab_height_z]);
    }
}

// ----------------------------------------------------------
// Subtractive features
// ----------------------------------------------------------
module spacer_cuts() {
    // --- Bar bore (concentric with cylinder) ---
    translate([0, 0, -1])
        cylinder(d = spacer_id + printer_tol * 2,
                 h = spacer_height + 2);

    // --- LED bore (horizontal through-hole along Y) ---
    // Aligned with cylinder width, centred at (led_bore_cx, 0, spacer_height/2).
    // Goes completely through the tab in Y.
    translate([led_bore_cx, -tab_width_y / 2 - 1, spacer_height / 2])
        rotate([-90, 0, 0])
            cylinder(d = led_bore_dia + printer_tol * 2,
                     h = tab_width_y + 2);

    // --- Threaded set-screw hole (horizontal, from +X face) ---
    // Enters from outer face, travels through screw_wall into LED bore.
    translate([tab_outer_x + 1, 0, screw_z])
        rotate([0, -90, 0])
            threaded_hole(screw_dia, screw_pitch,
                          screw_wall + 2,
                          screw_clearance);
}

// ----------------------------------------------------------
// Assembled spacer
// ----------------------------------------------------------
module led_spacer() {
    difference() {
        spacer_body();
        spacer_cuts();
    }
}

// ----------------------------------------------------------
// Set-screw (separate part for printing)
// ----------------------------------------------------------
module set_screw() {
    screw_length = screw_wall + led_bore_dia / 4;
    head_dia     = screw_dia * 2;
    head_height  = 2;

    union() {
        // Hex head
        cylinder(d = head_dia, h = head_height, $fn = 6);

        // Threaded shaft
        translate([0, 0, head_height])
            metric_thread(screw_dia, screw_pitch,
                          screw_length - head_height,
                          screw_clearance);
    }
}

// ----------------------------------------------------------
// Layout: mount + set-screw (well separated for printing)
// ----------------------------------------------------------

// Main spacer
led_spacer();

// Set-screw placed clear of mount
translate([tab_outer_x + 20, 0, 0])
    set_screw();
