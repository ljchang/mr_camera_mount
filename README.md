# MR Camera Mount — IR LED Spacer

A 3D-printed cylindrical spacer that holds an infrared LED (in a titanium housing) for use with an MR-compatible camera system from [MRC Systems](https://www.mrc-systems.de/).

## Features
- Cylindrical spacer (26 mm OD × 5 mm ID × 10 mm tall) slides onto the MRC Systems mounting bar
- 12 mm bore (15 mm deep) accepts the titanium-housed IR LED
- Rectangular clamping tab with a threaded set-screw to secure the LED
- Fully parametric — edit `src/parameters.scad` to adjust dimensions

## Requirements
- [OpenSCAD](https://openscad.org/) (tested with 2024.x)

## Usage
1. Open `src/led_spacer.scad` in OpenSCAD.
2. Adjust parameters in `src/parameters.scad` if needed.
3. Render (F6) and export STL for printing.

## Printing Notes
- Material: PLA or PETG (non-ferromagnetic, MR safe)
- Infill: 50–80 %
- Layer height: 0.15–0.2 mm recommended for thread quality
