$fn = 100;

inner_width = 21;
outer_width = 32.6;

flange_depth = 6;
flange_base_width = 19;
flange_length = 25;

wall_thickness = 2;

holder_distance = 114;
length = holder_distance + flange_length + wall_thickness;

baseplate_width = outer_width+wall_thickness*2;

screw_hole_small = 4.5/2;
screw_hole_large = 8/2;
screw_hole_top_location = 100;
screw_hole_bottom_location = 40;


module flange(){
	hull(){
		cube([flange_length, outer_width, 0.001]);
		translate([0, (outer_width-inner_width)/2, flange_depth]){
			cube([flange_length, inner_width, 0.001]);
		}
	}
}

module holder_hull(){
	hull(){
		cube([flange_length+wall_thickness, outer_width+wall_thickness*2, 0.001]);
		translate([0, (outer_width-inner_width)/2, flange_depth]){
			cube([flange_length+wall_thickness, inner_width+wall_thickness*2, 0.001]);
		}
	}
	
}

module holder(){
	difference(){
		holder_hull();
		translate([0, wall_thickness, 0]){
			flange();
		}
	}
}

module baseplate(){
	difference(){
		cube([length, baseplate_width, wall_thickness]);
		translate([screw_hole_top_location,baseplate_width/2,0]){
			cylinder(wall_thickness, screw_hole_small, screw_hole_large);
		}
		translate([screw_hole_bottom_location,baseplate_width/2,0]){
			cylinder(wall_thickness, screw_hole_small, screw_hole_large);
		}

	}
}

module mounting_bracket(){
	union(){
		baseplate();
		translate([0,0,wall_thickness]){
			holder();
		}
		translate([holder_distance,0,wall_thickness]){
			holder();
		}
	}

}
//holder();
//baseplate();

mounting_bracket();
