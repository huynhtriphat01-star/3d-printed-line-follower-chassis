# 3D-Printed Line-Follower Chassis

![Assembled line-following robot](media/images/assembled-line-follower.jpg)

Custom one-piece chassis for a line-following and maze-solving robot. The frame was modeled in OpenSCAD, fabricated by 3D printing, and evaluated with the real electronics and sensor layout shown below.

## Design goals

- One-piece printable frame with a rigid Y-shaped front section.
- Mounting area for the line-sensor array and controller board.
- Adjustable slots for the two motor brackets.
- Recess and mounting holes for a 3PI-style ball caster.
- Uprights for an HC-SR04 ultrasonic sensor.
- Cable-tie and hook-and-loop strap openings.

## Prototype

| Printed chassis | Assembled robot |
|---|---|
| ![Printed chassis](media/images/printed-chassis.jpg) | ![Assembled robot](media/images/assembled-line-follower.jpg) |

## Demonstration videos

- [Line-following demonstration 1](media/videos/line-following-demo-1.mp4)
- [Line-following demonstration 2](media/videos/line-following-demo-2.mp4)

## CAD files

The `cad/F_Maze_V5_2_HCSR04/` directory contains:

- `F_Maze_V5_2_CAD_KiemTra_HCSR04.scad` — editable OpenSCAD model.
- `F_Maze_V5_2_KHUNG_THU_LAP_CHUA_IN.stl` — STL exported for slicer preview.
- `THAY_DOI_V5_2.txt` — revision notes and validation status.
- `THONG_SO_HC_SR04.txt` — HC-SR04 reference dimensions.

Open the `.scad` file in OpenSCAD. Select `assembly`, `frame`, `top2d`, or `side2d` with the `MODE` parameter, then press **F5** to preview.

## Known dimensions

| Item | Value |
|---|---:|
| Controller-board front hole spacing | 40 mm |
| Controller-board rear hole spacing | 48 mm |
| Controller-board row spacing | 55 mm |
| Line-sensor mounting-hole spacing | 20 mm |
| Motor-bracket hole spacing | 17 mm |
| 3PI caster mounting-hole spacing | 15 mm |
| HC-SR04 outer envelope | 43 × 20 × 17 mm |
| Nominal wheel diameter | 44 mm |

## Validation warning

V5.2 is a fit-check prototype, not a production-ready or competition-approved design. Before final printing, measure and verify:

- motor-bracket holes and axle height;
- controller-board position;
- HC-SR04 mounting-hole pitch;
- caster housing shape and ground contact;
- wheel clearance and complete weight distribution.

Print a small mounting test coupon first where practical.

## Repository structure

```text
.
├── cad/
│   └── F_Maze_V5_2_HCSR04/
├── media/
│   ├── images/
│   └── videos/
└── README.md
```

## Status

- Physical chassis printed.
- Electronics and line sensor mounted on a prototype.
- Two demonstration videos included.
- Final dimensional validation remains required before competition use.

No open-source license is declared. All rights are reserved unless the owner adds a license.
