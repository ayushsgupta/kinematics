class Segment {
  PVector a; 
  float len;
  float angle;
  float selfAngle;
  
  float xoff = random(1000); 
  
  Segment parent = null;
  Segment child = null;
  
  PVector b;
 
  
  Segment(float x, float y, float len_, float angle_) {
    a = new PVector(x, y); 
    len = len_; 
    angle = radians(angle_);
    selfAngle = angle;
    calculateB();
    parent = null;
  }
  
  Segment(Segment parent_, float len_, float angle_) {
    parent = parent_;
    a = new PVector(parent.b.x, parent.b.y); 
    len = len_; 
    angle = radians(angle_);
    selfAngle = angle;
    calculateB();
  }
  
  void wiggle() {
    float maxangle = 1; 
    float minangle = -1;
    //selfAngle = map(sin(xoff), -1, 1, maxangle, minangle);
    selfAngle = map(noise(xoff), 0, 1, maxangle, minangle);
    xoff += 0.01;
    //selfAngle = selfAngle += 0.01;
  }
  
  void update() {
    angle = selfAngle;
    if (parent != null) {
      a = parent.b.copy();
      angle += parent.angle;
    } 
    else {
      angle += -PI/4;
    }
    calculateB();
  }
  
  void calculateB() {
      float dx = len * cos(angle); 
      float dy = len * sin(angle);
      b = new PVector(a.x + dx, a.y + dy);
  }
  
  void show() {
    stroke(255);
    strokeWeight(4);
    line(a.x, a.y, b.x, b.y);
  }
}