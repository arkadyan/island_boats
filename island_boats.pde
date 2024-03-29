import toxi.processing.*;

private static final int WORLD_WIDTH = 680;
private static final int WORLD_HEIGHT = 480;

private static final color WATER_COLOR = #0000b5;

private int timeOfLastBoat;

// Whether or not to display extra visuals for debugging.
private boolean debug = false;

ToxiclibsSupport gfx;

// The material field the vehicles are following.
FlowField flowField;
// A collection of boats.
ArrayList<Boat> boats;


void setup() {
  size(680, 480);
/*  size(1920, 1355);*/
  smooth();
  noCursor();
  ellipseMode(CENTER);
  
  gfx = new ToxiclibsSupport(this);
  
  // Make a new flow field with an arbitrary resolution of 16
  flowField = new FlowField(WORLD_WIDTH, WORLD_HEIGHT, 16);
  
  boats = new ArrayList();
  addBoat();
}

void draw() {
  background(WATER_COLOR);
  
  // Draw each of the boats.
  for (Boat boat : boats) {
    boat.update();
    boat.draw(gfx, debug);
  }
  
  // Display the flow field when in debug mode.
  if (debug) flowField.draw(gfx);
}


/**
 * Toggle the debug display by hitting the spacebar.
 */
void keyPressed() {
  if (key == ' ') debug = ! debug;
}

/**
 * Make a new flow field when the mouse is clicked.
 */
void mousePressed() {
  flowField.init();
}


/**
 * Add a new boat and record the time.
 */
private void addBoat() {
  boats.add(new Boat(new Vec2D(random(width), random(height)), random(2)));
  timeOfLastBoat = millis();
}
