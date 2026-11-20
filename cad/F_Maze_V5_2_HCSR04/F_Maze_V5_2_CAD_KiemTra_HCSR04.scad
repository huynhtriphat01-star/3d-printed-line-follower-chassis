/*
 F-MAZE Y-ONEPIECE CHASSIS V5.2 - HC-SR04 43x20x17 / PCB 40 FRONT 48 REAR
 Unit: millimeter.  Print frame as ONE continuous part.
 User confirmed: PCB 80x60, line sensor approx 100mm, sensor hole spacing 20mm,
 M2.5x16 for board where compatible, two 44mm wheels.
 Unverified: absolute PCB hole offsets from PCB edges, metal bracket to axle reference, HC-SR04 mounting pitch, ball caster full footprint, battery mass. Slots are ADJUSTMENT FEATURES, not guarantee of fit.
 Coordinate system: X left-right; -Y front; +Z up. Frame bottom Z=0.
 WARNING: assembled demo only visualizes approximate component bounding envelopes.
 V5.2 update: 43x20x17mm HC-SR04 visual envelope, actual mounting pitch NOT measured.
 Actual caster mounting boss cut fixed so the inset is no longer filled by the baseplate.
 This is fit-check CAD, NOT approved for production printing.
*/
// F-Maze V5.1: PCB FRONT near line sensor = 40mm, PCB REAR near motor tail = 48mm; between rows 55mm. N20 bracket 17mm; caster 15mm.
// CAUTION: approximate envelopes for components; exact holes and weight distribution UNVERIFIED.
// In OpenSCAD: Window > Customizer, select Assembly or Frame, press F5 to preview.
$fn=48;

/* [01 - Hien thi] */
MODE="assembly"; // [assembly:Mockup lap linh kien,frame:Chi khung de in,top2d:Hinh chieu tren,side2d:Hinh chieu ngang]

/* [02 - Kich thuoc khung mm] */
FRAME_T=3; // [2:0.5:5]
REAR_HALF_W=52; // [46:1:55] // NEW rear width = 104mm, 12mm wider than V4.1
REAR_FRONT_Y=3;
REAR_BACK_Y=66; // [60:1:75]
FRONT_SENSOR_Y=-68; // [-75:1:-57]
FRONT_BAR_W=108; // [100:1:120]
FRONT_BAR_DEPTH=11; // [8:1:16]

/* [03 - 8 mat do line] */
SENSOR_HOLE_CC=20; // [18:0.5:22] // Do thuc te 20mm tam-tam
SENSOR_HOLE_D=2.8; // [2.5:0.1:3.5] // Xac nhan duong kinh lo
SENSOR_SLOT_TRAVEL=3.2;

/* [04 - 4 lo bo PID Nano mm] */
PCB_FRONT_CC=40; // [35:0.5:55] // 2 lo PHIA CAM BIEN LINE = 40mm (DO DA XAC NHAN)
PCB_REAR_CC=48; // [40:0.5:60] // 2 lo PHIA DUOI XE GAN MOTOR = 48mm (DO DA XAC NHAN)
PCB_ROW_CC=55; // [45:0.5:57] // DA DO: khoang cach TAM giua 2 hang PCB
PCB_HOLES_CENTER_Y=34.5; // [28:0.5:38] // vi tri board tren KHUNG la tam CHON, chua do mep tren
PCB_HOLE_DIAMETER=2.8; // [2.5:0.1:3.5] // Lo xuyen de thu M2.5
PCB_HOLE_SLOT_TRAVEL=1.5; // [0:0.5:4] // Nua do dai truot theo truc Y

/* [05 - Ga motor N20] */
MOTOR_HOLE_CC=17; // [15:0.5:20] // DA DO: khoang cach hai lo tren ga kim loai
MOTOR_MOUNT_X=47.5; // [42:0.5:51] // NEW +7mm each side, bracket hole spacing still unverified
MOTOR_MOUNT_Y=39; // [23:1:53]
MOTOR_SLOT_D=2.8; // [2.5:0.1:3.5]
WHEEL_CENTER_X=66; // [60:0.5:68] // RIM envelope: (66+9)*2=150mm for 18mm wheel width

/* [06 - Bi do Hshop 3PI, gan o duoi gan cam bien] */
CASTER_Y=-41; // [-46:1:-32] // gan dau xe, cach cam bien ~27mm
CASTER_HOLE_CC=15; // [13:0.5:18]
CASTER_RECESS_D=23.6; // [22.2:0.2:26] // lo lap thu duong kinh, su dung recess ma KHONG ep vo ABS
CASTER_RECESS_DEPTH=3; // [1:0.5:5] // chua chac: neu flange an sau 3mm, 15-3=12mm

/* [07 - HC SR04: user-supplied outer size, hole pitch still unmeasured] */
SR04_BOARD_WIDTH=43; // user: horizontal width mm
SR04_BOARD_HEIGHT=20; // user: board vertical height mm
SR04_MODULE_DEPTH=17; // user: total depth mm incl transducers
SR04_POST_X=18.5; // [16:0.5:20] DEFAULT ONLY: assumed 37mm post-to-post, board-hole spacing NOT VERIFIED
SR04_POST_Y=-22; // [-34:1:-13]
SR04_POST_TOP=45; // [35:1:55]
SR04_SLOT_LOW=21;
SR04_SLOT_HIGH=40;
SR04_SLOT_D=2.8;

/* [08 - Linh kien hien thi mau, CHI UOC LUONG] */
PCB_CENTER_Y=34.5; // [25:1:48]
PCB_BOTTOM_Z=7; // [4:1:14]
BATTERY_CENTER_Y=44; // [24:1:56] // CHUA XAC NHAN vi tri pin tren khung
BATTERY_BOTTOM_Z=22; // [16:1:35] // chieu cao lap thu, khong duoc coi la da phan tich va cham PCB
BATTERY_LEN=65; // [60:1:70] // user measured
BATTERY_W=35; // [30:1:42] // user measured
BATTERY_H=18; // [14:1:25] // user measured

/* [09 - Do cao] */
UNDERFRAME_GAP=12; // [9:0.5:15] // khoang cach mat duoi khung toi san, user measured from previous chassis
WHEEL_DIAMETER=44; // [40:1:46]
MOTOR_AXLE_TO_BRACKET_MEASURE=25; // [15:1:32] // user measured but reference axis/surface NOT YET CONFIRMED: DO NOT use to define axle Z
LINE_SENSOR_W=14; // [10:1:20] // user measured width; sensor hole DIAMETER remains unknown

/* [Hidden] */
// Reusable 2D primitives
module smooth_bar(x1,y1,x2,y2,width){
  hull(){translate([x1,y1])circle(d=width);translate([x2,y2])circle(d=width);}
}
module slot2d(x1,y1,x2,y2,d){
  hull(){translate([x1,y1])circle(d=d);translate([x2,y2])circle(d=d);}
}
module rounded_box2d(sx,sy,r){
  hull(){for(x=[-sx/2+r,sx/2-r])for(y=[-sy/2+r,sy/2-r])translate([x,y])circle(r=r);}
}
module rear_base_2d(){
  difference(){
    polygon([[-(REAR_HALF_W-5),REAR_FRONT_Y],[(REAR_HALF_W-5),REAR_FRONT_Y],[REAR_HALF_W,9],
             [REAR_HALF_W,60],[(REAR_HALF_W-6),REAR_BACK_Y],[-(REAR_HALF_W-6),REAR_BACK_Y],
             [-REAR_HALF_W,60],[-REAR_HALF_W,9]]);
    // Two large lightening apertures leaving board support rails and cross member.
    translate([0,21])rounded_box2d(44,16,4);
    translate([0,47])rounded_box2d(42,15,4);
    // Side relief apertures preserve outer rails near motor area.
    for(side=[-1,1]){
       translate([side*32,21])rounded_box2d(9,9,2.5);
       translate([side*32,53])rounded_box2d(9,9,2.5);
    }
  }
}
module y_plan_2d(){
   union(){
     rear_base_2d();
     // central backbone with truss branches
     smooth_bar(0,8,0,-63,9);
     for(s=[-1,1]){
        smooth_bar(s*35,5,s*5,-50,7.3);
        smooth_bar(s*20,-22,0,-46,4.7);
        smooth_bar(s*33,5,s*41,16,8);
     }
     smooth_bar(-18,-22,18,-22,5.7);
     smooth_bar(-27,-2,27,-2,5.6);
     // Perpendicular 8-eye sensor rail, 108 mm wide
     translate([0,FRONT_SENSOR_Y])rounded_box2d(FRONT_BAR_W,FRONT_BAR_DEPTH,3);
     // Central web behind rail for extra rigidity
     smooth_bar(0,-58,0,FRONT_SENSOR_Y+2,11);
   }
}
// PCB & motor slotted holes and Velcro access
module base_holes_2d(){
   // USB & ribbon access behind sensor rail; does NOT sever the rail.
   translate([0,FRONT_SENSOR_Y+0.8])rounded_box2d(12,5.6,1.4);
   // Verified 20mm spacing, +/-10mm from center. Elongate along Y.
   for(x=[-SENSOR_HOLE_CC/2,SENSOR_HOLE_CC/2])
     slot2d(x,FRONT_SENSOR_Y-1.6,x,FRONT_SENSOR_Y+1.6,SENSOR_HOLE_D);
   // CONFIRMED physical orientation: near the line sensor (-Y), two holes 40mm apart.
   // Near the rear motor/tail (+Y), two holes 48mm apart. Row pitch 55mm.
   // PCB_CENTER_Y selected for mock layout, absolute offset to PCB edge not measured exactly.
   for(s=[-1,1]) {
     slot2d(s*PCB_FRONT_CC/2,PCB_HOLES_CENTER_Y-PCB_ROW_CC/2-PCB_HOLE_SLOT_TRAVEL,
            s*PCB_FRONT_CC/2,PCB_HOLES_CENTER_Y-PCB_ROW_CC/2+PCB_HOLE_SLOT_TRAVEL,
            PCB_HOLE_DIAMETER);
     slot2d(s*PCB_REAR_CC/2,PCB_HOLES_CENTER_Y+PCB_ROW_CC/2-PCB_HOLE_SLOT_TRAVEL,
            s*PCB_REAR_CC/2,PCB_HOLES_CENTER_Y+PCB_ROW_CC/2+PCB_HOLE_SLOT_TRAVEL,
            PCB_HOLE_DIAMETER);
   }
   // Motor metal bracket adjustable pair per side (exact holes not confirmed)
   for(s=[-1,1])for(y=[MOTOR_MOUNT_Y-MOTOR_HOLE_CC/2,MOTOR_MOUNT_Y+MOTOR_HOLE_CC/2])
      slot2d(s*MOTOR_MOUNT_X,y-3,s*MOTOR_MOUNT_X,y+3,MOTOR_SLOT_D);
   // Velcro strap access in remaining rear rails, useful with board-on-standoffs.
   for(y=[9.5,60.5]) for(s=[-1,1])
      slot2d(s*20,y,s*25,y,3.2);
   // Side wire tie anchor holes; place safely away from rim
   for(s=[-1,1]){
      translate([s*38,31])circle(d=3.2);
      translate([s*8,-53])circle(d=3.2);
   }
}
module caster_mount(){
   // Single molded boss; cavity from UNDER the plate for sinking the 3PI caster.
   // Caster pocket and through-holes MUST be subtracted after ALL unions (see one_piece_frame).
   translate([0,CASTER_Y,0])
   difference(){
       union(){cylinder(h=8,d=35);}
       // underside pocket 24.3 diameter, 4 mm deep
       translate([0,0,-0.2])cylinder(h=CASTER_RECESS_DEPTH+0.2,d=CASTER_RECESS_D);
       // central small free passage; genuine ball housing shape TBD
       translate([0,0,CASTER_RECESS_DEPTH-0.05])cylinder(h=8,d=9.0);
           // Hshop 3PI: TWO screw holes in transverse X axis, center-to-center 15mm.
       // Check mounting screw DIAMETER and housing fit using a quick test coupon.
       for(xx=[-CASTER_HOLE_CC/2,CASTER_HOLE_CC/2])
         translate([xx,0,CASTER_RECESS_DEPTH-0.1])cylinder(h=9,d=2.8);
   }
}
module sr04_upright(side){
   translate([side*SR04_POST_X,SR04_POST_Y,0])
   difference(){
      union(){
         // Upright column integrated with truss arm, 8x7mm section
         translate([-4,-3.5,0])cube([8,7,SR04_POST_TOP]);
         // gusset behind the post for rigidity and stress spreading
         hull(){
           translate([-5,0,2])cube([10,10,3]);
           translate([-3,3,24])cube([6,4,2]);
         }
      }
      // An adjustable VERTICAL slot, viewed from front. Axis through Y.
      hull(){
         translate([0,-5,SR04_SLOT_LOW])rotate([90,0,0])cylinder(h=13,d=SR04_SLOT_D,center=true);
         translate([0,-5,SR04_SLOT_HIGH])rotate([90,0,0])cylinder(h=13,d=SR04_SLOT_D,center=true);
      }
   }
}
// ASSEMBLY WIDTH CHECK: 2 * (WHEEL_CENTER_X + 18/2) = 150 mm nominal.
// Physical motor hole spacing and exact wheel offset require measurement.
module one_piece_frame(){
   // PRIMARY solid: a continuous, printable frame
   // Cut the caster cavity AFTER joining the plate to the boss; prior V5.1's
   // boss-only cavity was partly FILLED by the overlapping main plate.
   difference(){
     union(){
       difference(){
         linear_extrude(height=FRAME_T) y_plan_2d();
         translate([0,0,-0.2])linear_extrude(height=FRAME_T+0.4)base_holes_2d();
       }
       // Motor platform reinforcement, continuous with one-piece rear frame
       for(s=[-1,1])translate([s*MOTOR_MOUNT_X,MOTOR_MOUNT_Y,FRAME_T])
          difference(){
            hull(){for(yy=[MOTOR_MOUNT_Y-17,MOTOR_MOUNT_Y+17])
               translate([0,yy-MOTOR_MOUNT_Y,0])cylinder(h=1.5,d=11);}
            for(y=[MOTOR_MOUNT_Y-MOTOR_HOLE_CC/2,MOTOR_MOUNT_Y+MOTOR_HOLE_CC/2])
                 translate([-s*MOTOR_MOUNT_X, -MOTOR_MOUNT_Y, -0.1])
                   linear_extrude(height=2)slot2d(s*MOTOR_MOUNT_X,y-3,s*MOTOR_MOUNT_X,y+3,MOTOR_SLOT_D);
          }
       // Solid boss, relieved by external cuts below
       translate([0,CASTER_Y,0])cylinder(h=8,d=35);
       for(s=[-1,1])sr04_upright(s);
     }
     // Underside inset: allows the 15mm caster housing to sit 3mm higher.
     // WARNING: a round pocket is only a trial profile, not the full measured 3PI outline.
     translate([0,CASTER_Y,-0.15])
       cylinder(h=CASTER_RECESS_DEPTH+0.15,d=CASTER_RECESS_D);
     // Housing central clearance; small bore avoids excessive loss of structure.
     translate([0,CASTER_Y,CASTER_RECESS_DEPTH-0.01])
       cylinder(h=8.1,d=9);
     // Exact user-supplied spacing: TWO caster mounting screw holes, pitch 15mm.
     for(x=[-CASTER_HOLE_CC/2,CASTER_HOLE_CC/2])
       translate([x,CASTER_Y,-0.1])cylinder(h=9,d=2.8);
   }
}

// The components below are **visual reference envelopes only**, NOT printed STL.
// VIEW ONLY: colors show estimated bounding boxes. Motor braces/PCB screw positions are NOT exact.
module assembly_visualization(){
  color([0.88,0.38,0.13]) one_piece_frame();
  // Motor-to-wheel offset is an illustrative parameter and NOT a verified mechanical dimension.
  // Physical PCB orientation: red/front=40mm toward line sensor (-Y);
  // yellow/rear=48mm toward motors (+Y). These are only position markers.
  for (side=[-1,1]) {
    color("red") translate([side*PCB_FRONT_CC/2,PCB_HOLES_CENTER_Y-PCB_ROW_CC/2,PCB_BOTTOM_Z+2]) cylinder(d=4,h=1);
    color("yellow") translate([side*PCB_REAR_CC/2,PCB_HOLES_CENTER_Y+PCB_ROW_CC/2,PCB_BOTTOM_Z+2]) cylinder(d=4,h=1);
  }
  // PID Nano PCB 80x60, approximate location on rear pad
  color([0.05,0.18,0.52,0.75])translate([-40,PCB_CENTER_Y-30,PCB_BOTTOM_Z])cube([80,60,1.6]);
  // user battery 65x35x18; location/height REPRESENTATIVE, not validated interference/CG
  color([0.16,0.16,0.19,0.7])translate([-BATTERY_LEN/2,BATTERY_CENTER_Y-BATTERY_W/2,BATTERY_BOTTOM_Z])cube([BATTERY_LEN,BATTERY_W,BATTERY_H]);
  // 44x18 wheel envelopes (shown at likely wheel position)
  for(s=[-1,1]){
    color([0.1,0.12,0.15])translate([s*WHEEL_CENTER_X,MOTOR_MOUNT_Y,WHEEL_DIAMETER/2-UNDERFRAME_GAP])rotate([0,90,0])cylinder(h=18,d=WHEEL_DIAMETER,center=true);
    color([0.7,0.75,0.81])translate([s*(WHEEL_CENTER_X+1),MOTOR_MOUNT_Y,WHEEL_DIAMETER/2-UNDERFRAME_GAP])rotate([0,90,0])cylinder(h=19,d=14,center=true);
    color([0.5,0.5,0.5])translate([s*(WHEEL_CENTER_X-15),MOTOR_MOUNT_Y,WHEEL_DIAMETER/2-UNDERFRAME_GAP])rotate([0,90,0])cylinder(h=18,d=12,center=true);
  }
  // 8-channel sensor PCB; 100mm width, approximate
  color([0.03,0.04,0.07,0.75])translate([-50,FRONT_SENSOR_Y-LINE_SENSOR_W/2,-5])cube([100,LINE_SENSOR_W,1.5]);
  for(i=[0:7]) color([0.96,0.80,0.05])translate([-44+i*12.6,FRONT_SENSOR_Y-LINE_SENSOR_W/2,-5.3])cube([5,4,0.7]);
  // Hshop ball caster is 15mm tall, flange inset 3mm => ball lowest = (3-15) = -12 (GROUND)
  color([0.86,0.88,0.90])translate([0,CASTER_Y,CASTER_RECESS_DEPTH-7])cylinder(h=7,d=19);
  color([0.66,0.68,0.69])translate([0,CASTER_Y,CASTER_RECESS_DEPTH-15+6])sphere(d=12);
  // HC-SR04 reference envelope from user: exactly 43 mm wide, 20 high, 17 deep.
  // Approximate 1.6mm board and protruding transducers; HOLES REMAIN UNMEASURED.
  color([0.06,0.18,0.51])
    translate([-SR04_BOARD_WIDTH/2,SR04_POST_Y-5,23])
      cube([SR04_BOARD_WIDTH,1.6,SR04_BOARD_HEIGHT]);
  for(s=[-1,1]) color([0.73,0.77,0.79])
    translate([s*12.4,SR04_POST_Y-5,33])
      rotate([90,0,0])cylinder(d=15,h=SR04_MODULE_DEPTH-1.6);
  // Ground reference ONLY (assembly), at -UNDERFRAME_GAP mm below frame bottom.
  color([0.25,0.68,0.24,0.18])translate([-79,-80,-UNDERFRAME_GAP-0.35])cube([158,165,0.25]);
  // approximate rear sensor cable path (visual only)
  color([0.5,0.5,0.5])translate([0,-59,-2])cube([3,35,2]);
}

if(MODE=="assembly")assembly_visualization();
else if(MODE=="top2d")projection(cut=false)one_piece_frame();
else if(MODE=="side2d")projection(cut=false)rotate([90,0,0])one_piece_frame();
else one_piece_frame();
