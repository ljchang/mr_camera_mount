// ============================================================
// parameters.scad — Shared dimensions for MR Camera LED Spacer
// All values in millimeters.
// ============================================================

// --- Cylinder spacer ---
spacer_od       = 26;      // outer diameter of the cylinder
spacer_id       = 5;        // inner diameter (bar bore)
spacer_height   = 10;       // height of the cylinder

// --- LED bore ---
led_bore_dia    = 12;       // diameter of the LED pocket
led_bore_depth  = 15;       // depth of the LED pocket

// --- Clamping tab ---
tab_width       = 14;       // width of the rectangular tab
tab_length      = 18;       // how far the tab extends from cylinder centre
tab_height      = 10;       // same as spacer height (flush top/bottom)

// --- Set-screw (threaded hole through tab into LED bore) ---
screw_dia       = 4;        // M4 screw nominal diameter
screw_pitch     = 0.7;      // M4 fine-pitch thread
screw_clearance = 0.2;      // extra clearance for plastic threads

// --- Bar bore split-clamp (optional tightening slit) ---
clamp_slit_width = 1.5;     // width of the slit for clamping onto bar

// --- Tolerances ---
printer_tol     = 0.15;     // general printer tolerance added to bores

// --- Rendering quality ---
$fn = $preview ? 50 : 100;  // coarse in preview, fine for render
