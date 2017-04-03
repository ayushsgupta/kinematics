Segment tentacle;
final int seg_length = 100;
final int seg_num = 3;

void setup() {
  size(1200, 1200);
  Segment current = new Segment(300, 200, seg_length, 0);
  for (int i = 0; i < seg_num; i++) {
    Segment next = new Segment(current, seg_length, 0);
    current.child = next;
    current = next;
  }
  tentacle = current;
}

void draw() {
  background(51);
  
  tentacle.follow(mouseX, mouseY);
  tentacle.update();
  tentacle.show();
  
  Segment next = tentacle;
  next = next.parent;
  while (next != null) {
    next.update();
    next.show();
    next.follow();
    next = next.parent;
  }
  /*
  seg2.follow(mouseX, mouseY);
  seg1.update();
  seg2.update();
  seg1.show();
  seg2.show();
  seg1.follow(seg2.a.x, seg2.a.y);*/
}