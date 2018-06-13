//---------------------------
// Simulation Class
//---------------------------
class Simulation
{  
  ArrayList particles;

  int count = 0;
  Simulation()
  {
    particles = new ArrayList();    
  }
  
  void init()
  {
  }
  
  void update()
  { 
    for (int i=0; i<particles.size(); i++) 
    {
      Particle po = (Particle) particles.get(i);   
      po.update();
      
      if(po.getLife()<0){
        particles.remove(i);
      }
    }
  }
  
  void render()
  {
    noStroke();  
    for (int i=0; i<particles.size(); i++) 
    {
      Particle po = (Particle) particles.get(i);   
      po.render();
    }
  }
  
  void addNewParticle(int x, int y, color c, float r)
  {
    PVector p = new PVector(x,y);
    Particle part = new Particle(p, c, r);
    particles.add(part);
  }
}