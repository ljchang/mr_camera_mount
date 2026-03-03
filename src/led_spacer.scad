// ============================================================
// led_spacer.scad — MR-Compatible IR LED Spacer Mount
//
// A cylindrical spacer that slides onto the MRC Systems
// mounting bar. A lateral bore accepts the titanium-housed
// IR LED, held in place by a threaded set-screw through a
// rectangular clamping tab.
// ============================================================

use <parameters.scad>   // won't work — use `include` for variables
include <parameters.scad>
include <threads.scad>

// ----------------------------------------------------------
// Main body: cylinder + clamping tab
// ----------------------------------------------------------
module spacer_body() {
    union() {
        // --- Main cylinder ---
        cylinder(d = spacer_od, h = spacer_height);

        // --- Rectangular clamping tab ---
        // Extends from the cylinder edge outward along +X.
        // Centred on Y, flush top/bottom with cylinder.
        translate([0, -tab_width / 2, 0])
            cube([tab_length, tab_width, tab_height]);
    }
}

// ----------------------------------------------------------
// Subtractive features (bores, screw holes, slit)
// ----------------------------------------------------------
module spacer_cuts() {
    // --- Centre bore for mounting bar ---
    translate([0, 0, -1])
        cylinder(d = spacer_id + printer_tol * 2,
                 h = spacer_height + 2);

    // --- LED bore (enters from top, centred on cylinder) ---
    // The bore is deeper than the spacer height because the
    // LED housing is 15 mm long but the spacer is only 10 mm.
    // So the bore goes all the way through and then some.
    // We place it offset from centre toward the tab side so
    // there is wall thickness on the opposite side.
    led_offset_x = (spacer_od / 2 - led_bore_dia / 2) / 2;
    translate([led_offset_x, 0, -1])
        cylinder(d = led_bore_dia + printer_tol * 2,
                 h = spacer_height + 2);

    // --- Threaded set-screw hole (through tab into LED bore) ---
    // Oriented along +X, enters from outside of tab.
    screw_z = spacer_height / 2;  // vertically centred
    screw_y = 0;                   // centred on tab width

    translate([tab_length + 1, screw_y, screw_z])
        rotate([0, -90, 0])
            threaded_hole(screw_dia, screw_pitch,
                          tab_length - led_offset_x + 2,
                          screw_clearance);

    // --- Clamping slit through cylinder wall (for bar grip) ---
    // A thin slot from the bar bore outward, allowing the
    // cylinder to flex slightly when clamped on the bar.
    translate([-spacer_od / 2 - 1,
               -clamp_slit_width / 2,
               -1])
        cube([spacer_od / 2 - spacer_id / 2 + 1,
              clamp_slit_width,
              spacer_height + 2]);
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
    screw_length = tab_length;
    head_dia     = screw_dia * 2;
    head_height  = 2;

    union() {
        // Head (knurled-ish — hex for now)
        cylinder(d = head_dia, h = head_height, $fn = 6);

        // Threaded shaft
        translate([0, 0, head_height])
            metric_thread(screw_dia - screw_clearance,
                          screw_pitch,
                          screw_length - head_height);
    }
}

// ----------------------------------------------------------
// Layout for preview / printing
// ----------------------------------------------------------

// Main spacer
led_spacer();

// Set-screw placed beside the spacer for printing
translate([spacer_od + 10, 0, 0])
    set_screw();
