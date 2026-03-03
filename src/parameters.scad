// ============================================================
// parameters.scad — Shared dimensions for MR Camera LED Spacer
// All values in millimeters.
// ============================================================

// --- Cylinder spacer ---
spacer_od       = 26;       // outer diameter of the cylinder
spacer_id       = 5;        // inner diameter (bar bore, concentric)
spacer_height   = 10;       // height (width) of the cylinder along bar axis (Z)

// --- LED bore (horizontal through-hole, along Y, parallel to cylinder width) ---
led_bore_dia    = 12;       // diameter of the LED pocket
led_bore_depth  = 15;       // bore length (through-hole along Y)

// --- Rectangular tab ---
// Extends from cylinder surface in +X.
// LED bore runs along Y (aligned with cylinder width direction).
// Overlaps into cylinder for a solid one-piece union.
min_wall        = 3;        // minimum wall around LED bore
screw_wall      = 8;        // wall on +X screw-entry side (thread engagement)
tab_overlap     = 3;        // overlap into cylinder body for solid attachment

// Tab position
tab_start_x     = spacer_od / 2 - tab_overlap;                    // 10 mm

// LED bore centre X (wall between bore and cylinder surface)
led_bore_cx     = spacer_od / 2 + min_wall + led_bore_dia / 2;    // 22 mm

// Tab outer face (where screw enters)
tab_outer_x     = led_bore_cx + led_bore_dia / 2 + screw_wall;    // 36 mm

// Tab dimensions
tab_width_x     = tab_outer_x - tab_start_x;                      // 26 mm (radial)
tab_width_y     = led_bore_depth;                                  // 15 mm (bore through-hole along Y)
tab_height_z    = led_bore_dia + min_wall * 2;                     // 18 mm (bore dia + walls)

// Tab centred on cylinder in Z
tab_z_offset    = (spacer_height - tab_height_z) / 2;             // -4 mm

// --- Set-screw (horizontal, enters from +X face into LED bore) ---
screw_dia       = 4;        // M4 nominal diameter
screw_pitch     = 0.7;      // M4 fine-pitch thread
screw_clearance = 0.2;      // extra clearance for plastic threads
screw_z         = spacer_height / 2;  // centred on cylinder height

// --- Tolerances ---
printer_tol     = 0.15;     // general printer tolerance added to bores

// --- Rendering quality ---
$fn = $preview ? 50 : 100;  // coarse in preview, fine for render
