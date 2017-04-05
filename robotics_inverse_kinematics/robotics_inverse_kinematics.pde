RobotArm bottom;
RobotArm top;

float target_x = 0.0;
float target_y = 0.0;

void setup() {
  size(800, 800);
  bottom = new RobotArm(width / 2, height / 2);
  //bottom = new RobotArm(0, 0);
  top = new RobotArm(bottom);
  
}

void draw() {
  background(45, 167, 255);
  handleDrawUpdate();
  handleTarget();
  if (readjustPossible() && notOriginTarget()) {
    adjustToTarget();
  }
  line(0, 0, target_x, target_y);
  print("ENDPOINT: (" + top.b.x + ", " + top.b.y + ")\n");
}

void handleTarget() {
  setTarget();
  drawTarget();
}

void setTarget() {
  if (mousePressed == true) {
    target_x = mouseX;
    target_y = mouseY;
  }
}

void drawTarget() {
  if (notOriginTarget()){
    stroke(0);
    ellipse(target_x, target_y, 5, 5);
    stroke(255);
  }
}

void handleDrawUpdate() {
  bottom.update();
  top.update();
  bottom.show();
  top.show();
}

boolean readjustPossible() {
  return ((bottom.len + top.len) >= dist(bottom.a.x, bottom.a.y, target_x, target_y));
}

boolean notOriginTarget() {
  return (target_x != 0.0 && target_y != 0.0);
}

void adjustToTarget() {
  float target_distance = dist(bottom.a.x, bottom.a.y, target_x, target_y);
  float bottom_angle = lawOfCosines(top.len, bottom.len, target_distance);
  print("BOTTOM ANGLE: " +  degrees(bottom_angle) + "\n");
  
  PVector to_target;
  to_target = new PVector(target_x, target_y);
  print("TARGET HEADING: " + degrees(to_target.heading()) + "\n");
  
  PVector direction;
  direction = to_target.sub(bottom.a);
  float direction_heading = direction.heading();
  print("DIRECTION HEADING: " + degrees(direction_heading) + "\n");
  
  float target_heading_bottom = (target_x <= width / 2) ? direction_heading - bottom_angle : direction_heading + bottom_angle;
  float target_heading_top = (target_x <= width / 2) ? PI - (2 * bottom_angle) : PI + (2 * bottom_angle);
  
  print("TARGET HEADING BOTTOM: " + degrees(target_heading_bottom) + "\n");
  print("TARGET HEADING TOP: " + degrees(target_heading_top) + "\n");
  
  //target_heading_bottom -= radians(90.0);
  //target_heading_top -= radians(90.0);
  
  bottom.setSelfAngle(target_heading_bottom);
  top.setSelfAngle(target_heading_top);
  top.correctHeading();
}

float lawOfCosines(float a, float b, float c) {
    return acos((pow(a, 2) - pow(b, 2) - pow(c, 2)) / (-2 * b * c));
}


/*
void adjustToTarget() {
  PVector to_target;
  PVector direction;
  
  to_target = new PVector(target_x, target_y);
  direction = to_target.sub(bottom.a);
    
  float direction_heading = direction.heading();
  float direction_mag = direction.mag();
  float diff_angle = lawOfCosines(direction_mag);
  
  float target_heading_bottom = direction_heading - diff_angle;
  float target_heading_top = 180.0 - (2 * diff_angle);
  
  bottom.setSelfAngle(target_heading_bottom);
  top.setSelfAngle(target_heading_top);
  
}

float lawOfCosines(float mag) {
  float expr = (pow(bottom.len, 2) + pow(mag, 2) - pow(top.len, 2)) / (2 * bottom.len * mag);
  float diff_angle = acos(expr);
  return diff_angle;
}*/