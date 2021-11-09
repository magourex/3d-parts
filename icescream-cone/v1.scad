angle = 28; // Angle du code (à la base)
height = 100; // Hauteur du cone
nbL = 16; // nombre de ligne
aRotate = 360; // Angle d'enroulement (360 = 1 tour)
eCube = 1; // Epaisseur cube
mult = 2;
difference(){
  union(){
    difference(){
        cylinder(height+eCube, 1, tan(angle/2) * height + 1);
        translate([0,0,eCube+1])cylinder(height+eCube, 0, tan(angle/2) * height);
    }

    for (vrot = [ 0:1:aRotate*mult ])
        if((vrot < aRotate*mult/4 && vrot%20 == 0) ||
           (vrot >= aRotate*mult/4 && vrot < aRotate*mult/2 && vrot%10 == 0) ||
           (vrot >= aRotate*mult/2 && vrot < aRotate*mult*3/4 && vrot%8 == 0) ||
           (vrot >= aRotate*mult*3/4 && vrot < aRotate*mult*7/8 && vrot%4 == 0) ||
           (vrot >= aRotate*mult*7/8 && vrot < aRotate*mult*15/16 && vrot%2 == 0) ||
           vrot >= aRotate*mult*15/16){
        rot = vrot / mult;
        hypoHz = rot<360 ? height / cos(rot/4) : 0;
        eLHz = hypoHz / nbL;
        hypoVt = rot<360 ? height / cos(360 - rot/4) : 0;
        eLVt = hypoVt / nbL;
        angHz = 90-asin(height/hypoHz);
        rotate([0,0,rot]) {
            if(hypoHz > 0 && rot < 360) 
                for (i = [1:1:nbL])
                   if(i * eLHz < height && (i * eLHz > height /2 || vrot%2 == 0)) {
                      y = i*eLHz;
                      x = -(tan(angle/2) * y) - eCube;
                       
                      translate([x,0,y])rotate([0,90-angle/2,0])rotate([0,0,-angHz])
                      color("blue")cube([eCube, eCube*((y+10)/height)*5, eCube], center = true);   
                   }
         }
         rotate([0,0,-rot])
            if(hypoVt > 0 && rot < 360) 
                for (i = [1:1:nbL])
                   if(i * eLVt < height && (i * eLHz > height /2 || vrot%2 == 0)) {
                      y = i*eLVt;
                      x = -(tan(angle/2) * y) - eCube;
                      translate([x,0,y])rotate([0,90-angle/2,0])rotate([0,0,angHz])
                      color("red")cube([eCube,eCube*((y+10)/height)*5,eCube], center = true);   
                   }
        vrot = vrot+10;
    }

    color("green")
    translate([-eCube*2,-eCube/2,0])rotate([0,-angle/2,0])
    translate([eCube/2,0,6])
        cube([eCube,eCube,(height / cos(angle/2))-6]);
  }
  translate([0,0,height])cylinder(100,100,100);
}