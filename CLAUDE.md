# MR Camera Mount — IR LED Spacer

## Project Overview
3D-printed spacer/mount for an infrared LED used with an MR-compatible camera system.
The LED and main camera mount are manufactured by MRC Systems. This spacer adapts the
LED (in a titanium housing) to the MRC Systems mounting bar.

## Design Parameters (millimeters)
| Parameter | Value |
|---|---|
| Spacer outer diameter | 26 mm |
| Spacer inner diameter (bar bore) | 5 mm |
| Spacer height | 10 mm |
| LED bore diameter | 12 mm |
| LED bore depth | 15 mm |
| LED housing material | Titanium |

The spacer includes a rectangular tab with a threaded set-screw hole to clamp the LED
in place. The inner bore slides onto a mounting bar that can be tightened to set the
angle.

## Tech Stack
- **CAD**: OpenSCAD (parametric, text-based 3D modeling)
- **Print material**: Likely PLA or PETG (non-ferromagnetic, MR safe)

## File Layout
```
├── CLAUDE.md          # this file
├── README.md          # project description
├── src/
│   ├── led_spacer.scad       # main assembly
│   ├── parameters.scad       # shared dimensions
│   └── threads.scad          # thread-generation helpers
├── exports/           # generated STL files (gitignored except .gitkeep)
└── docs/              # reference images, datasheets
```

## Conventions
- All dimensions in millimeters
- Use `$fn` of at least 100 for final renders; 50 for preview
- Keep parameters centralized in `parameters.scad`
- Comment tolerances and clearances explicitly
- MR-safe: no ferromagnetic hardware — use nylon/brass/titanium fasteners
