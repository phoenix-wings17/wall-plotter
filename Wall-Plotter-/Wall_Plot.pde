import processing.net.*;
import java.io.File;
import java.util.*;
import geomerative.*;
import java.io.IOException;

layout l;

int delay_flag = 0;

File directoryPath = new File("D:\\PD\\Visulization\\Wall_Plot\\designs");
String contents[] = directoryPath.list();


List <svgs> vectors = new ArrayList();

void setup(){
  size(900,600);
  l = new layout(200,150,100,100);  
  V_operation("init"); 
}

void draw(){
  background(0);
  activity();
  contents = directoryPath.list();
}

void activity(){
  
  switch(l.active_opt){
    
    case 0:
      l.impot();
      break;
    
    case 1:
      V_operation("show");
      break;
      
    case 2:
       
       V_operation("show");
       
       if(delay_flag==0){
         delay_flag +=1;}
       else{
          V_operation("export");
          delay_flag = 0;}
          
      break;
      
    case 3:
      //text("WORK IN PROGRESS",(width-100)/2,(height-100)/2 + l.y_off);
      V_operation("simulate");

      break;
      
    case 4:
      text("About US",(width-100)/2,(height-100)/2 + l.y_off);
      break;
      
  }
  
  l.show();
  
}

void mouseDragged(){
  if(l.active_opt==1 && vectors.size()!=0){
    vectors.get(l.active_layer).check_changes();
  }
}

void mousePressed(){
 
  l.check_btn_press();
  loop();  
}

void keyPressed() {
  if (!mousePressed) {
    
    switch(key) {
      
      case 'S':
        V_operation("simulate");      
        break;
        
      case 'E':
        V_operation("export");
        break;
      
      case 'D':
        V_operation("duplicate");
        break;
        
      case 'X':
        V_operation("delete");
        break;
    }
  }
  
  if(l.active_opt == 0){

    if(keyPressed){
      
      if(int(key)>=49 && int(key) < contents.length + 48 ){
        V_operation("import");
      }
    }
  } 
}

void V_operation(String opt){
  
  switch(opt){
    
    case "init":
      RG.init(this);
      RG.ignoreStyles(true);
      RG.setPolygonizer(RG.ADAPTATIVE);
      break;
   
    case "import":
      
      vectors.add(new svgs(contents[int(key)-49]));
      l.duplicate(contents[int(key)-49]);
      break;
       
    case "show": 
      for (int i =0; i<vectors.size();i++){
        vectors.get(i).show();
      }
      break;
      
    case "save":
      for(int i =0; i<vectors.size();i++){
        vectors.get(i).gen_points();  
      }
      break;
    
    case "export":
      
      V_operation("save");
      
      String[] coordinates = {"let wdth = " + (width - l.x_off) + ";\nlet higt = "+ (height - l.y_off)+";\nlet bot_wd = "+l.bot_wd+";\nlet bot_ht = "+l.bot_ht+";\n"};
    
      coordinates[0] += "let points = [";
      
      for(int k =0; k<vectors.size(); k++){
        
        
        for (int i =0;i<vectors.get(k).points.length;i++){
          
          coordinates[0] += "[";
          
           for(int j =0;j<vectors.get(k).points[i].length;j++){
             
             coordinates[0] += "[" + vectors.get(k).points[i][j].x + "," + vectors.get(k).points[i][j].y + "]";
             
              if (j != vectors.get(k).points[i].length-1) {
                
                coordinates[0] += "," ;
                
              }
              
            } coordinates[0] += "],\n";
        }
       
      }
      coordinates[0] += "];"; 
      println("Exporting Finished...!!!");
      
      saveStrings("./simulate/coordinates.js",coordinates);
      saveStrings("coordinates.txt",coordinates);
      
      l.active_opt = 1;  
      break;
    
    case "simulate":
      V_operation("export");
      print("Simulating...!!!");
      link("file:///D:/PD/Visulization/Wall_Plot/simulate/index.html");
      l.active_opt = 1;  
      break;    
    
    case "duplicate":
    
      vectors.add(new svgs(vectors.get(l.active_layer).name));
      vectors.get(vectors.size()-1).x = vectors.get(l.active_layer).x;
      vectors.get(vectors.size()-1).y = vectors.get(l.active_layer).y;
      vectors.get(vectors.size()-1).size = vectors.get(l.active_layer).size;
      vectors.get(vectors.size()-1).angle = vectors.get(l.active_layer).angle;
      l.duplicate(vectors.get(l.active_layer).name);
      break;
    
    case "delete":
      if(l.layers.size() > 0){
        vectors.remove(l.active_layer);
        l.delete();
      }
      break;
  }
}
