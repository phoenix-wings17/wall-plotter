class svgs{
  
  float size = 0.5;
  float angle = 0;
  float x = (width - l.x_off)/2, y = l.y_off + (height - l.y_off)/2;
  
  String name;
  
  RShape shp;
  RPoint [][] points;
  
  svgs(String file_name){
    
    name = file_name;
    load_svg();
    
  }
  
  void show(){
      
    stroke(255);
    
    pushMatrix();
    
    translate(x,y);
    rotate(angle);
    scale(size);
    shp.draw();
    
    popMatrix();
  
  }

void check_changes(){
  
  int code = keyCode;
  
  if(key=='r'){ code =82;}
  
  switch(code){
    
    case 82:
      if(keyPressed){
        
        angle = atan2(mouseY-y,mouseX-x);
        
        if (angle < 0) {
          angle = - map(angle, -PI, 0, PI, 0);
        } 
        else if (angle > 0) {
          angle = - map(angle, 0, PI, TWO_PI, PI);
        }     
      }
      break;
   
    case 17:
      if(keyPressed){ 
        x = mouseX;
        y = mouseY;
      }
      break;
    
    case 16:
        if(keyPressed){
          size = map(2*dist(x,y,mouseX,mouseY),0.01,dist(x,y,width,height),0.01,1);
        }
        break;
    }
  }
  
 void gen_points(){
   
   shp.scale(size);
   shp.rotate(angle);
   shp.translate(x, y - l.y_off);
   points = shp.getPointsInPaths();
   
   load_svg();
   
 }
 
 void load_svg(){
   
   shp = RG.loadShape("./designs/"+name);
   shp.centerIn(g);
   
 }


}//END OF CLASS
