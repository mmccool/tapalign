// Tube tap alignment tool
// for holding tap while putting threads inside steel pipe
// All dimensions in mm

eps = 0.01; // numerical tolerance for CSG
tol = 0.2;  // amount by which printer "spreads"
sm = 30;

R = 25;  // outer radius of pipe
r = 18; // shaft radius of tap
h = 50;  // length of tap shaft
H = 100; // length of alignment segment
t = 3; // wall thickness
w = 6; // window radius
n = 6; // number of window columns
m = 5; // number of window rows
v = w+10; // window start displacement

difference() {
  cylinder(r=R+t,h=H+h,$fn=2*sm);
  translate([0,0,-eps])
    cylinder(r=r+tol,h=H+h+2*eps,$fn=4*sm);
  translate([0,0,-eps])
    cylinder(r=R+tol,h=H+eps,$fn=4*sm);
  for (j = [0:m-1]) {
    for (i = [0:n-1]) {
      translate([0,0,v+j*(H-2*v)/(m-1)])
        rotate([0,0,360*(i+(0.5*(j%2)))/n])
          rotate([90,0,0])
            cylinder(r=w,h=R+t+eps,$fn=sm);
    }
  }
}