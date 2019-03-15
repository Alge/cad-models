mm = 3.77452249757;

radius = 75*mm;
wall_thickness = 4*mm;

spokes = 21;
spoke_clearance = 2;
middle_cylinder = 40*mm;

middle_hole_x = 3*mm;
middle_hole_y = 5*mm;

module pie_slice(r=3.0,a=30) {
    $fn=64;
    difference() {
        intersection() {
            circle(r);
            square([r, r]);
            rotate(a-90) square([r,r]);
        }
        circle(middle_cylinder-wall_thickness);
    }
}

module bottom(){
    difference(){
        circle($fa=1, radius);
        pie_slice(radius-wall_thickness-spoke_clearance, a=360/spokes);
        circle($fa=1, middle_hole_x+spoke_clearance) ;
    }

}

module ring(){
    difference(){
        circle($fa=1, radius);
        circle($fa=1, radius-wall_thickness);
    }
}

module wheel(){
    difference(){
        circle($fa=1, radius-wall_thickness-spoke_clearance);
        circle($fa=1, radius-wall_thickness*2-spoke_clearance);
    }
    for (i = [0:spokes]){
        degrees = 360/spokes;
        rotate([0,0, degrees*i]) translate([0,-wall_thickness/2,0]) square([radius-wall_thickness-spoke_clearance, wall_thickness]);
    }
    circle(middle_cylinder);
}

module middle(){
    difference(){
        wheel();
        translate([-middle_hole_x/2, -middle_hole_y/2, 0]){
            square([middle_hole_x, middle_hole_y]);
        }
    }
}

//ring();
bottom();
//middle();

//translate([0,0,30*mm]) ring();
//translate([0,0,-30*mm])bottom();
