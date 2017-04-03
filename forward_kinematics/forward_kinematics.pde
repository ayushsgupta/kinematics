Segment tentacle;
Segment seg2;
final int len_seg = 20;
final int num_seg = 50;

void setup() {
  size(1000, 1000);
  tentacle = new Segment(width / 2, height / 2, len_seg, 0);
  
  Segment current = tentacle;
  for (int i = 0; i < num_seg; i++) {
    Segment next = new Segment(current, len_seg, 0);
    current.child = next;
    current = next;
  }
}

void draw() {
  background(50);
  Segment next = tentacle;
  while (next != null) {
    next.wiggle();
    next.update();
    next.show();
    next = next.child;
  }
}