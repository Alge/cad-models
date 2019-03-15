
radius = 70;
height = 25;
wall_thickness = 2;

spokes = 21;
spoke_clearance = 1;
middle_cylinder = 35;

middle_hole_radius = 3;

module pie_slice(r=3.0,a=30, h=1.0) {
  $fn=64;
  intersection() {
    cylinder(h, r, r);
    cube([r, r, h]);
    rotate(a-90) cube([r,r,h]);
  }
}

module box(){
    difference(){

        difference(){
            difference(){
                cylinder($fa=1,height, radius, radius);
                translate([0, 0, wall_thickness]) cylinder($fa=1, height, radius-wall_thickness, radius-wall_thickness);
            }
            translate([0,0,-1]) cylinder($fa=1,height+2, middle_hole_radius+wall_thickness, middle_hole_radius+wall_thickness);
        }
        
        translate([0,0,-1]) difference(){
            pie_slice(r=radius-wall_thickness-spoke_clearance, a=360/spokes, h=height); 
            translate([0,0,-1]) cylinder(height+2, middle_cylinder-wall_thickness, middle_cylinder-wall_thickness);
        }
    }

    
}

module wheel(){
    difference(){
        cylinder($fa=1,height-wall_thickness, radius-wall_thickness-spoke_clearance, radius-wall_thickness-spoke_clearance);
        translate([0,0,-1]) cylinder($fa=1,height-wall_thickness+2, radius-wall_thickness*2-spoke_clearance, radius-wall_thickness*2-spoke_clearance);
    }
    for (i = [0:spokes]){
        degrees = 360/spokes;
        rotate([0,0, degrees*i]) translate([0,-wall_thickness/2,0])cube([radius-wall_thickness-spoke_clearance, wall_thickness, height-wall_thickness]);
    }
    cylinder(height-wall_thickness, middle_cylinder, middle_cylinder);
}

module middle(){
    difference(){
        translate([0,0,0]) wheel();
        translate([0,0,-1]) cylinder($fa=1,height+2, middle_hole_radius, middle_hole_radius);
    }    
}

//box();
middle();
//translate([0 ,0, wall_thickness + 1]) middle();

