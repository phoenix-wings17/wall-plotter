class BOT{
  
  constructor(wd,ht,r){
    
    this.wd = wd;
    this.ht = ht;
    this.r = r;
    
    this.pen_color = [246,36,89];
    this.MW = false;
    this.pen_r = 20;    
    
    this.theta_1 = 0;
    this.theta_2 = 0;
    
    this.pos = createVector(width/2,height/2); 
    
    this.r1 = dist(0,0,width/2,height/2-ht/2);
    this.r2 = dist(width,0,width/2,height/2-ht/2);
    
    this.update(this.r1,this.r2)
    
  }
  
  async show(){
    
    noFill();
    stroke(0);
    strokeWeight(2);
    rectMode(CENTER);
    textAlign(CENTER,CENTER);
    
    line (0,0 ,this.pos.x , this.pos.y - this.ht/2);
    line (width,0 ,this.pos.x,this.pos.y- this.ht/2);
    
    if(magic){
      imageMode(CENTER);
      image(bot_fg,this.pos.x,this.pos.y-12.5);
      imageMode(CORNER);
    }
    
    fill(this.pen_color);
    ellipse(this.pos.x,this.pos.y,2*this.pen_r);
    noFill();
    text("PEN",this.pos.x,this.pos.y);
    
    strokeWeight(5);    
    if(!magic){
      rect(this.pos.x,this.pos.y,this.wd,this.ht);
    
    
      push();
      translate(this.pos.x - this.wd/2 + this.r, this.pos.y - this.ht/2 + this.r);
      rotate(this.theta_2);
      ellipse(0,0,2*this.r);
      line(0,0,this.r,0);
      line(0,0,-this.r/2,this.r*sqrt(3)/2);
      line(0,0,-this.r/2,-this.r*sqrt(3)/2);
      pop();
      
      push();
      translate(this.pos.x + this.wd/2 - this.r, this.pos.y - this.ht/2 + this.r);
      rotate(this.theta_1);
      ellipse(0,0,2*this.r);
      line(0,0,-this.r,0);
      line(0,0,this.r/2,this.r*sqrt(3)/2);
      line(0,0,this.r/2,-this.r*sqrt(3)/2);
      pop();
    }
    
    
    await sleep(delay_time);
  }
  
  
  async move(x,y){
    
    let temp_y = y - this.ht/2;
    
    let nr1 = sqrt(x**2 + temp_y**2)
    let nr2 = sqrt((width - x)**2 + temp_y**2) ;
    
    let ang1 = (nr1 - this.r1)/this.r;
    let ang2 = (nr2 - this.r2)/this.r;
    
    await this.servo(ang1,ang2);
    
  }
  
  async servo(angle_1,angle_2){
    
    let da1 = this.r*angle_1/res;
    let da2 = this.r*angle_2/res;
    
    for (let i = 0;i< res;i++){
      
      background(0);
      if(magic){image(mg_bg,0,0);}
      else{image(bg,0,0);}
      image(can2,0,0);
      
      
      this.theta_1 += da1;
      this.theta_2 += da2;
      

      await this.update(this.r1 + da1, this.r2 + da2);
    }
  }
  
  
  async update(r1,r2){
    
    
    let cos_theta = (width**2 + r1**2 - r2**2 )/(2*width*r1);

    this.pos.x = r1*cos_theta ;    
    this.pos.y = r1*sqrt(1-cos_theta**2) + (this.ht)/2 ;
    
    this.r1 = r1;
    this.r2 = r2;
     
    await this.show();
    
  }
  
  pen_act(){
    if(this.MW){
      this.MW = false;
      this.pen_color = [246,36,89];
    }
    else{
      this.MW = true;
      this.pen_color = [0,177,106];
    }
    
    
  }
  
  
}//END OF CLASS
