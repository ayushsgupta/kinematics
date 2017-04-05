class RobotArm {
  float len = 200;
  float self_angle = radians(-90);
  float calc_angle = self_angle;
  
  PVector a;
  PVector b = new PVector();
  
  RobotArm parent = null;
  
  RobotArm(float x, float y) {
    a = new PVector(x, y);
    findEndpoint();
  }
  
  RobotArm(RobotArm parent_) {
    a = new PVector(parent_.b.x, parent_.b.y);
    parent = parent_;
    findEndpoint();
  }
  
  void findEndpoint() {
    selfCalcEqual();
    float dx = len * cos(calc_angle);
    float dy = len * sin(calc_angle);
    b.set(a.x + dx, a.y + dy);
  }
   
  void show() {
    stroke(255);
    strokeWeight(5);
    line(a.x, a.y, b.x, b.y);
  }
  
  void update() {
    if (parent != null) {
      a = parent.b.copy();
      calc_angle = self_angle + parent.self_angle;
    }
    findEndpoint();
  }
 
  
  void moveAngle(float diff) {
    self_angle -= diff;
    selfCalcEqual();
  }
  
  void setSelfAngle(float angle) {
    self_angle = angle;
    selfCalcEqual();
  }
  
  void selfCalcEqual() {
    if (parent == null) {
      calc_angle = self_angle;
    }
  }
  
  void setEndpoint(float x, float y) {
    b.set(x, y);
  }
  
  void correctHeading() {
    PVector header;
    header = b.sub(a);
    
    PVector parent_header;
    parent_header = parent.b.sub(parent.a);
    
    float between = PVector.angleBetween(header, parent_header);
    float diff = abs(between - 90.0) * 2;
    calc_angle += diff;
  }
  
  void setByEndpoint(PVector endpoint) {
    self_angle = acos((endpoint.x - a.x) / len);
    if (endpoint.y <= height / 2) {
      self_angle *= -1;
    }
  }
}