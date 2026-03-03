// ============================================================
// parameters.scad — Shared dimensions for MR Camera LED Spacer
// All values in millimeters.
// ============================================================

// --- Cylinder spacer ---
spacer_od       = 26;       // outer diameter of the cylinder
spacer_id       = 8.2;      // inner diameter (bar bore, concentric)
spacer_height   = 10;       // height (width) of the cylinder along bar axis (Z)

// --- LED bore (horizontal through-hole, along Y, parallel to cylinder width) ---
led_bore_dia    = 12;       // diameter of the LED pocket
led_bore_depth  = 15;       // bore length (through-hole along Y)

// --- Rectangular tab ---
// Extends from cylinder surface in +X.
// LED bore runs along Y (aligned with cylinder width direction).
// A transition zone smoothly morphs from the cylinder's circular
// profile to the full rectangle so the spacer can still stack.
min_wall        = 3;        // minimum wall around LED bore
screw_wall      = 10;       // wall on +X screw-entry side (thread engagement)
transition_len  = 5;        // length of smooth cylinder-to-rectangle transition

// LED bore centre X (beyond transition zone + wall)
led_bore_cx     = spacer_od / 2 + transition_len + min_wall + led_bore_dia / 2;  // 27 mm

// Tab outer face (where screw enters)
tab_outer_x     = led_bore_cx + led_bore_dia / 2 + screw_wall;    // 43 mm

// Tab cross-section at the rectangular end (Y × Z)
tab_width_y     = led_bore_depth;                                  // 15 mm (bore through-hole along Y)
tab_height_z    = led_bore_dia + min_wall * 2;                     // 18 mm (bore dia + walls)

// Tab centred on cylinder in Z
tab_z_offset    = (spacer_height - tab_height_z) / 2;             // -4 mm

// --- Set-screw hole (horizontal, from +X face into LED bore) ---
// Plain cylindrical hole for M6 nylon thumbscrew.
// 5.0 mm = M6 tap drill size. Tap with M6 × 1.0 tap after
// printing, then use nylon thumbscrew by hand.
screw_hole_dia  = 5.0;
screw_z         = spacer_height / 2;  // centred on cylinder height

// --- Tolerances ---
printer_tol     = 0.15;     // general printer tolerance added to bores

// --- Rendering quality ---
$fn = $preview ? 50 : 100;  // coarse in preview, fine for render
