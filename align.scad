// Tube tap alignment tool
// for holding tap while putting threads inside steel pipe
// All dimensions in mm

eps = 0.01;  // numerical tolerance for CSG overlap
tol = 0.2;   // amount by which printer "spreads"
clear = 0.3; // looser tolerance for parts that need clearance
sm = 50;     // smoothness (10 for dev, 50 for release)

R = 25.5/2;  // outer radius of tube to be tapped
r = 17.9/2;  // shaft radius of tap
h = 60;      // length of tap shaft (not counting wrench nut)
H = 40;      // length of tap teeth section
E = 40;      // length of alignment extension (how far past teeth)
S = H + E;   // total length of sleeve
L = h + S;   // total length
t = 2;       // min wall thickness (at tip of tube sleeve)
b = R + t;   // min outer radius
B = R + 3;   // max radius of tap shaft sleeve (at base of tube sleeve)
w = 5;       // window radius
n = 6;       // number of window columns
m = 5;       // number of window rows
ws = 1.5;    // vertical scaling of windows
wsm = 4;     // window smoothness (2*sm for circles, 4 for diamonds)
v = w+10;    // window start displacement
W = 100/2;   // radius of "base adhesion" extension
a = 0.21;    // thickness of "base adhesion" extension
C = 25;      // base radius
Ch = (C-B);  // base height
Ch2 = 5;     // height of non-tapered part of base
Cc = C-1;    // radius of "inset" part at bottom (helpful for dismounting)
Cch = 1;     // height of "inset"

module tapalign() {
  difference() {
    union() {
      translate([0,0,L-Cch])
        cylinder(r1=C,r2=Cc,h=Cch,$fn=2*sm); // small lip for easy removal from platform
      translate([0,0,L-Ch2-eps])
        cylinder(r=C,h=Ch2+2*eps-Cch,$fn=2*sm); // base cylinder
      translate([0,0,L-Ch-Ch2])
        cylinder(r1=B+eps,r2=C,h=Ch,$fn=2*sm); // base taper
      translate([0,0,S-eps])
        cylinder(r=B+eps,h=h+eps,$fn=2*sm); // tap shaft
      cylinder(r1=b,r2=B,h=S+eps,$fn=2*sm); // tube sleeve
      // Use "brim" option in Cura instead
      // translate([0,0,L-a])
      //  cylinder(r=W,h=a); // base adhesion layer
    }
    translate([0,0,-eps])
      cylinder(r=r+tol,h=L+2*eps,$fn=4*sm); // tap shaft hole
    translate([0,0,-eps])
      cylinder(r=R+clear,h=S+eps,$fn=4*sm); // tube sleeve hole
    // windows (for visibility, chip and air escape)
    for (j = [0:m-1]) {
      for (i = [0:n-1]) {
        translate([0,0,v+j*(S-2*v)/(m-1)])
          rotate([0,0,360*(i+(0.5*(j%2)))/n])
            scale([1,1,ws])
              rotate([90,0,0])
                cylinder(r=w,h=B+t+eps,$fn=wsm);
      }
    }
  }
}

translate([0,0,L])
  rotate([180,0,0])
    tapalign();