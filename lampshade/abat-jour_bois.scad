reso = 100;

d_int_fix = 40;
d_ext_fix = 70;
h_fix = 5;

r_abat = 150;
d_abat = 4;
h_abat = 5;
ang_abat = 40;

ep_fen = 20;
ep_fen_int = 25;
h_fen = .750;

ang_abat_fix = 19;

module fix() {
    difference() {
        cylinder(r=d_ext_fix/2, $fn=reso, h=h_fix);
        cylinder(r=d_int_fix/2, $fn=reso, h=h_fix);
        apat_complet();
    }
}

module abat_2(){
    translate([-d_abat-d_int_fix/2,0,0])rotate([0,0,-ang_abat/2])
        rotate_extrude(angle=ang_abat, convexity=10) {
            translate([d_abat+d_int_fix/2,0,0])
                square([r_abat, h_abat]);
        }   
}

module abat_fenetre(){
    translate([-d_abat+ep_fen-d_int_fix/2,0,1])rotate([0,0,-ang_abat/2])
        rotate_extrude(angle=ang_abat, convexity=10) {
            translate([d_abat+d_int_fix/2,0,0])
                square([r_abat-ep_fen*1.5, h_abat]);
        }   
}

module abat_fenetre_int(){
    translate([-d_abat+ep_fen_int-d_int_fix/2,0,0])rotate([0,0,-ang_abat/2])
        rotate_extrude(angle=ang_abat, convexity=10) {
            translate([d_abat+d_int_fix/2,0,0])
                square([r_abat-ep_fen_int*1.5, h_abat]);
        }   
}

module fenetre_int(){
    translate([-d_abat+ep_fen+1-d_int_fix/2,0,0])rotate([0,0,-ang_abat/2])
        rotate_extrude(angle=ang_abat, convexity=10) {
            translate([d_abat+d_int_fix/2,0,0])
                square([r_abat-(ep_fen+1)*1.5, h_fen]);
        }   
}

module abat_1() {
    difference() {
        abat_2();
        abat_fenetre();
        abat_fenetre_int();
    }
}

module abat() {
    translate([d_abat+1+d_int_fix/2,0,h_abat-1])rotate([0,ang_abat_fix,0])
        abat_1();
}

module apat_complet() {
   for (a =[0:3]) {
       rotate(90*a) abat();
   }
}

fenetre_int();
//abat_1();
//fix();