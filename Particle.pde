//---------------------------
// Particle class
//---------------------------
float gravity = 9.8;
float mass = 1.0;
float damping = 0.65;
float timestep = 0.02;

class Particle
{
  PVector pos;
  PVector vel;
  color col;
  float diameter;
  int life;
  
  Particle(PVector p, color c, float r)
  {
    pos = p;
    col = c;
    diameter = r * 2;
    vel = new PVector(0.0, 0.0);
    life = 60;
  }
  
  void update()
  {
    vel.y += 0.5*mass*gravity*gravity*timestep;
    pos.x += vel.x*timestep;
    pos.y += vel.y;
    
    // Y direction
    if(pos.y > (height - getRadius()))
    {
       vel.y = -vel.y * damping * random(0.01, 1.0);
       pos.y = height - getRadius(); 

       // friction
       //vel.x *= damping;
       vel.x = random(-100,100);
  }
    
    // X direction
    if(pos.x < getRadius())
    {
       vel.x = -vel.x;
       pos.x = getRadius();       
      
    }else if(pos.x > width - getRadius()){
       vel.x = -vel.x;
       pos.x = width - getRadius();       
    }  
    life--;
  }
  void render()
  {
    fill(col);
    ellipse(pos.x, pos.y, diameter, diameter);    
  }
  
  void setPos(PVector p)
  {
     pos.x = p.x; 
     pos.y = p.y; 
  }
  
  void setVel(PVector v)
  {
    vel.x = v.x;
    vel.y = v.y;
  }
  
  PVector getPos()
  {
     return pos; 
  }
  
  PVector getVel()
  {
     return vel; 
  }
  
  float getRadius()
  {
     return diameter/2.0; 
  }
  
  float getDamping()
  {
     return damping; 
  }
  
  int getLife()
  {
    return life;
  }
}