// Tube tap alignment tool
// for holding tap while putting threads inside steel pipe
// All dimensions in mm

eps = 0.01; // numerical tolerance for CSG
tol = 0.3;  // amount by which printer "spreads"
clear = 0.5;  // looser tolerance for part that need clearance
sm = 30;

R = 25/2;  // outer radius of tube to be tapped
r = 17.87/2; // shaft radius of tap
h = 60;  // length of tap shaft (not counting wrench nut)
H = 40; // length of tap teeth section
E = 40; // length of alignment extension (how far past teeth)
S = H + E; // total length of sleeve
L = h + S; // total length
t = 2; // min wall thickness
b = R + t; // min outer radius
B = 25; // max radius of base
w = 6; // window radius
n = 6; // number of window columns
m = 5; // number of window rows
v = w+10; // window start displacement

module tapalign() {
  difference() {
    union() {
      translate([0,0,S])
        cylinder(r=B,h=h,$fn=2*sm);
      cylinder(r1=b,r2=B,h=S+eps,$fn=2*sm);
    }
    translate([0,0,-eps])
      cylinder(r=r+tol,h=L+2*eps,$fn=4*sm);
    translate([0,0,-eps])
      cylinder(r=R+tol,h=H+E+eps,$fn=4*sm);
    for (j = [0:m-1]) {
      for (i = [0:n-1]) {
        translate([0,0,v+j*(S-2*v)/(m-1)])
          rotate([0,0,360*(i+(0.5*(j%2)))/n])
            rotate([90,0,0])
              cylinder(r=w,h=B+t+eps,$fn=sm);
      }
    }
  }
}

translate([0,0,L])
  rotate([180,0,0])
    tapalign();