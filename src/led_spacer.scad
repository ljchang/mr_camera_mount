// ============================================================
// led_spacer.scad — MR-Compatible IR LED Spacer Mount
//
// Cylinder slides onto the MRC Systems bar (bar axis = Z).
// A tab smoothly transitions from the cylinder's circular
// profile to a rectangular cross-section housing the LED bore.
// This transition lets other spacers stack against the cylinder
// without interference. The LED bore runs along Y. A nylon M8
// thumbscrew self-taps into a plain hole from the +X face to
// clamp the LED.
//
// Hardware:
//   - M6 nylon thumbscrew (MR-safe, hand-tightenable)
//   - Screw hole is 5.0 mm (M6 tap drill); tap after printing
//   - M6 × 1.0 taper tap + tap wrench needed for threading
//
// Coordinate system:
//   Z = bar / cylinder axis
//   Y = LED bore axis (aligned with cylinder width)
//   X = tab extends toward +X; screw enters from +X face
// ============================================================

include <parameters.scad>

// ----------------------------------------------------------
// Main body: cylinder + transition zone + rectangular tab
// ----------------------------------------------------------
module spacer_body() {
    rect_start_x = spacer_od / 2 + transition_len;

    union() {
        // --- Main cylinder (solid) ---
        cylinder(d = spacer_od, h = spacer_height);

        // --- Transition zone ---
        // hull() morphs from a thin arc of the cylinder surface
        // (circular profile, matching cylinder height) to the full
        // rectangular cross-section.
        hull() {
            // Thin arc slice at the cylinder surface
            intersection() {
                cylinder(d = spacer_od, h = spacer_height);
                translate([spacer_od / 2 - 1, -spacer_od / 2, 0])
                    cube([1.01, spacer_od, spacer_height]);
            }

            // Full rectangular cross-section at transition end
            translate([rect_start_x, -tab_width_y / 2, tab_z_offset])
                cube([0.01, tab_width_y, tab_height_z]);
        }

        // --- Rectangular block (LED bore housing + screw wall) ---
        translate([rect_start_x, -tab_width_y / 2, tab_z_offset])
            cube([tab_outer_x - rect_start_x,
                  tab_width_y,
                  tab_height_z]);
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
    translate([led_bore_cx, -tab_width_y / 2 - 1, spacer_height / 2])
        rotate([-90, 0, 0])
            cylinder(d = led_bore_dia + printer_tol * 2,
                     h = tab_width_y + 2);

    // --- Screw hole (plain cylinder for M8 nylon self-tapping) ---
    // Enters from +X face, goes through screw_wall into LED bore.
    translate([tab_outer_x + 1, 0, screw_z])
        rotate([0, -90, 0])
            cylinder(d = screw_hole_dia,
                     h = screw_wall + 2);
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
// Render
// ----------------------------------------------------------
led_spacer();
