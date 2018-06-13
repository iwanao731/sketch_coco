import processing.video.*;

boolean bFirstFrame = true;
int computeStep = 5;
float radius = 2.5;
color[] pix;
Simulation sim;
Movie myMovie;

void setup() {
  size(500,400);
  frameRate(30);
  pix = new int[width*height/2];

  myMovie = new Movie(this, "coco_clip.mp4");
  myMovie.loop();  
  
  sim = new Simulation();
  sim.init();  
}

void draw() 
{
  background(0);
  
  image( myMovie, 0, 0, width, height/2);
  loadPixels();  
  
  for (int i = 0; i < pixels.length/2; i++) 
  { 
    if(bFirstFrame){
      pix[i] = pixels[i];
      bFirstFrame = false;
    }
    else{      
      if(frameCount%computeStep == 0)
      {
        float dif = difColor(pixels[i], pix[i]);
        if(dif>200 && dif < 202){
          int x = i%width;
          int y = i/width;
          sim.addNewParticle(x, y, pix[i], radius);
        }
        pix[i] = pixels[i];
      }
    }
  }
  
  updatePixels(); 
  
  sim.update();
  sim.render();
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

float difColor(color c1, color c2)
{
  float rmean =(red(c1) + red(c2)) / 2;
  float r = red(c1) - red(c2);
  float g = green(c1) - green(c2);
  float b = blue(c1) - blue(c2);
  return sqrt((int(((512+rmean)*r*r))>>8)+(4*g*g)+(int(((767-rmean)*b*b))>>8));
}

int getFrame() {    
  return ceil(myMovie.time() * 30) - 1;
}