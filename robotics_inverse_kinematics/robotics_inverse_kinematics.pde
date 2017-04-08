RobotArm bottom;
RobotArm top;

PVector target;

float target_angle_bottom;
float target_angle_top;

void setup() {
  size(800, 800);
  bottom = new RobotArm(width / 2, height / 2);
  top = new RobotArm(bottom);
  target = new PVector();
}

void draw() {
  background(45, 167, 255);
  handleDrawUpdate();
  handleTarget(); 
  if (readjustPossible()) {
    adjustToTarget();
  }
}

void handleTarget() {
  setTarget();
  drawTarget();
}

void setTarget() {
  if (mousePressed == true) {
    target.set(mouseX, mouseY); 
  }
}

void drawTarget() {
  stroke(0);
  ellipse(target.x, target.y, 3, 3);
  strokeWeight(1);
  //line(0, 0, target.x, target.y);
  line(target.x, 0, target.x, height);
  line(0, target.y, width, target.y);
  //triangle(0, 0, 0, height / 2, width / 2, height / 2);
}

void handleDrawUpdate() {
  bottom.update();
  top.update();
  bottom.show();
  top.show();
}

boolean readjustPossible() {
  return ((bottom.len + top.len) >= dist(bottom.a.x, bottom.a.y, target.x, target.y));
}

void adjustToTarget() {
  PVector midpoint;
  midpoint = new PVector(((bottom.a.x + target.x) / 2), ((bottom.a.y + target.y) / 2));
  
  PVector direction;
  direction = target.copy().sub(bottom.a);
  //line(bottom.a.x, bottom.a.y, bottom.a.x + direction.x, bottom.a.y + direction.y);
  
  float perpendicular = (target.x >= width / 2) ? direction.heading() - radians(90) : direction.heading() + radians(90);
  PVector altitude;
  altitude = new PVector(1, 0);
  altitude.rotate(perpendicular);
  altitude.setMag(pythagoreanLeg((direction.mag() / 2), top.len));
  
  PVector join_point;
  join_point = new PVector(altitude.x + midpoint.x, altitude.y + midpoint.y);
  //line(midpoint.x, midpoint.y, join_point.x, join_point.y);
  
  bottom.setByEndpoint(join_point);
  top.setByEndpoint(target);
}

float pythagoreanLeg(float leg, float hyp) {
  float other_leg = sqrt(pow(hyp, 2) - pow(leg, 2));
  return other_leg;
}