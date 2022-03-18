class layout{
 
  int x_off,y_off;
  int bot_wd,bot_ht;
  int active_opt = 0;
  int active_layer = 0;
  
  List<String> layers;
  String [] option = {"Import","Modify","Export","Simulate"};
  
  float ver_sep;
  float hor_sep;
  float epsilon = 0.05;
  
  layout(int x,int y,int b_w,int b_h){
    
    x_off = x;
    y_off = y;
    bot_wd = b_w;
    bot_ht = b_h;
    layers =  new ArrayList<String>();

    hor_sep = (width)/option.length;
    //ver_sep = (height-y_off)/layers.size();
  }
    
  void impot(){

    float sep = (height-y_off-bot_ht*(3/2))/(contents.length + 4);
    textAlign(CORNER);
    textSize(30);
    text("Please Enter the Corresponding Index of your Desired SVG",bot_wd/1.7, y_off + bot_ht);
    textSize(sep);
    
    for(int i =0; i < contents.length;i++){
      text((i+1) + ") "+ contents[i], bot_wd/1.7, y_off + bot_ht + (i+1)*sep + (i+1)*sep/3 );
    }    
  }
  
  
  void show(){
    noFill();
    stroke(255);
    //strokeWeight(1);
    textSize(y_off/4);
    textAlign(CENTER,CENTER);
    
    if(layers.size()!=0){
      ver_sep = (height-y_off)/layers.size();
    }
    //Horizontal Lines
    line(width-x_off,y_off,width-x_off,height);
    
    //Vertical Layout
    for(int i = 0; i <layers.size(); i++){
      
      fill(0);
      rect(width-x_off, y_off + i*ver_sep,x_off, ver_sep);
      fill(255);
      text(layers.get(i),width - x_off/2,y_off + ver_sep/2 + i*ver_sep);
      noFill();
    }
    
    
    //Draw_able arear
    fill(0);
    noStroke();
    rect(0,y_off,width-x_off,bot_ht/2);
    rect(0,height-bot_ht/2,width-x_off,bot_ht/2);
    rect(0,y_off,bot_wd/2,height-y_off);
    rect(width-x_off-bot_wd/2,y_off,bot_wd/2,height-y_off);
    stroke(255);
    noFill();
    rectMode(CENTER);
    rect((width-x_off)/2,y_off+ (height-y_off)/2, width-x_off-bot_wd,height-y_off-bot_ht);
    rectMode(CORNER);
    
    //Horizontal Layout
    for(int i = 0; i <option.length; i++){
     fill(0);
     rect(i*hor_sep,0,hor_sep,y_off);
     fill(255);
     text(option[i], i*hor_sep + hor_sep/2 , y_off/2);
     noFill();
    }
    
    rect(0,-epsilon,width-epsilon,height);
    highlight();
  }
  
  void highlight(){
    
    strokeWeight(4);
    stroke(0,255,0);
    rect(active_opt*hor_sep,0,hor_sep,y_off);
    
    if(layers.size()!=0){
      rect(width-x_off, y_off + active_layer*ver_sep,x_off - epsilon, ver_sep - epsilon);
    }
    strokeWeight(1);
    stroke(255);
    
  }
  
  void check_btn_press(){
    
    if(mouseX > width-x_off && mouseY > y_off){
      
      for(int i = layers.size() - 1;i >= 0; i--){
        
        if(mouseY > y_off + i*ver_sep){
          
          active_layer = i;
          
          break; 
        }
      }
    }
    else if(mouseY < y_off){
      
      for(int j = option.length-1; j >=0;j--){
        
        if(mouseX > j*hor_sep){
         
          active_opt = j;
          
          break;
        }       
      }
    }
  }
  
  void duplicate(String name){
    
    layers.add(name);
    active_layer = layers.size()-1;
  }
    
  void delete(){
    
    layers.remove(active_layer);
    if(active_layer>0){active_layer -= 1;}
    
  }
  
}//END OF CLASS
  
  
  
  
  
  
  
