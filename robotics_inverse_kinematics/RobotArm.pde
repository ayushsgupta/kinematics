class RobotArm {
  float len = 200;
  //float len = random(50, 300);
  float self_angle = radians(270);
  float calc_angle = self_angle;
  //float ideal_angle = self_angle;
  
  int circle_radius = 5;
  int thickness = 3;
  float increment = 0.008;
  
  PVector a;
  PVector b = new PVector();
  PVector endpoint;
  
  RobotArm parent = null;
  
  RobotArm(float x, float y) {
    a = new PVector(x, y);
    findEndpoint();
    endpoint = b;
  }
  
  RobotArm(RobotArm parent_) {
    a = new PVector(parent_.b.x, parent_.b.y);
    parent = parent_;
    findEndpoint();
    endpoint = b;
  }
  
  void findEndpoint() {
    selfCalcEqual();
    float dx = len * cos(calc_angle);
    float dy = len * sin(calc_angle);
    b.set(a.x + dx, a.y + dy);
  }
   
  void show() {
    stroke(255);
    strokeWeight(thickness);
    line(a.x, a.y, b.x, b.y);
    if (parent == null) {
      rect(a.x - circle_radius / 2, a.y - circle_radius / 2, circle_radius, circle_radius);//(a.x, a.y, circle_radius * 2, circle_radius * 2);
    }
    else {
      ellipse(a.x, a.y, circle_radius, circle_radius);
    }
    ellipse(b.x, b.y, circle_radius, circle_radius);
  }
  
  void update() {
    if (parent != null) {
      a = parent.b.copy();
      calc_angle = self_angle + parent.self_angle;
    }
    reachIdealAngle();
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
      //ideal_angle = self_angle;
    }
  }
  
  void setByEndpoint(PVector end) {
    endpoint = end;
    /*ideal_angle = acos((endpoint.x - a.x) / len);
    if (parent == null && endpoint.y <= height / 2) {
      ideal_angle *= -1;
    }
    if (parent != null) {
      if (endpoint.y >= (height / 2)) {
        ideal_angle -= parent.self_angle;
      }
      else {
        ideal_angle -= parent.self_angle;
        if (inFirstQuadrant(endpoint)) {
          //ideal_angle += (2 * abs((PI / 2 + ideal_angle) + parent.self_angle));
          ideal_angle *= -1;
          
        }
        else if (inSecondQuadrant(endpoint)) {
          //ideal_angle -= 2 * abs(PI + ideal_angle + parent.self_angle) - parent.self_angle;
          ideal_angle *= -1;
        }
      }
      //ideal_angle  = (endpoint.y <= height / 2) ? ideal_angle - parent.self_angle : ideal_angle - parent.self_angle;
    }
    print(degrees(ideal_angle) + "\n");*/
  }
  
  void reachIdealAngle() {
    if (abs(b.x - endpoint.x) > 3 || abs(b.y - endpoint.y) > 3) {
      PVector to_b = new PVector(b.x - a.x, b.y - a.y);
      PVector to_end = new PVector(endpoint.x - a.x, endpoint.y - a.y);
      float angle_between = PVector.angleBetween(to_b, to_end);
      if (angle_between < 0) {
        self_angle += increment;
      }
      else if (angle_between < 180) {
        self_angle -= increment;
      }
      else {
        self_angle -= increment;
      }
    }
    print("TARGET: (" + endpoint.x +", " + endpoint.y + ")\n"); 
    print("CURRENT: (" + b.x +", " + b.y + ")\n"); 
  }
 
}