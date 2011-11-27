class FlowField {
  
  import toxi.geom.*;
  import toxi.processing.*;
  

  private static final color ARROW_COLOR = #cccccc;
  private static final int ARROW_SIZE = 4;
  
  private FlowFieldVector[][] field;   // A flow field is a two-dimensional array of vectors
  private int worldWidth, worldHeight;   // The size of the world
  private int resolution;
  private int cols, rows;
  
  
  FlowField(int ww, int wh, int r) {
    worldWidth = ww;
    worldHeight = wh;
    resolution = r;
    // Determine the number of columns and rows
    cols = worldWidth / resolution;
    rows = worldHeight / resolution;
    field = new FlowFieldVector[cols][rows];
    init();
  }
  
  
  /**
   * Use Perlin noise to seed the field vectors.
   */
  public void init() {
    // Reseed noise so we get a new flow field every time.
    noiseSeed((int)random(10000));
    
    float xoff = 0;
    for (int i=0; i < cols; i++) {
      float yoff = 0;
      for (int j=0; j < rows; j++) {
        // Polar to cartesian coordinate transformation to get 
        // x and y components of the vector.
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        field[i][j] = new FlowFieldVector(new Vec2D(i*resolution, j*resolution), new Vec2D(cos(theta), sin(theta)));
        yoff += 0.1;
      }
      xoff += 0.1;
    }
  }
  
  /**
   * Look up the vector at the requested location.
   */
  public Vec2D lookup(Vec2D lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    
    // Return a copy of the vector.
    return field[column][row].force().copy();
  }
  
  /**
   * Draw every vector as a grid of arrows.
   */
  public void draw(ToxiclibsSupport gfx) {
    for (int i=0; i < cols; i++) {
      for (int j=0; j < rows; j++) {
        drawVector(gfx, field[i][j], resolution-2);
      }
    }
  }
  
  
  /**
   * Renders a vector object as an arrow at a location.
   *
   * @param gfx  The Toxiclibs drawing object.
   * @param v  The vector to be drawn.
   * @param scayl  How much to scale the drawing of the vector.
   */
  private void drawVector(ToxiclibsSupport gfx, FlowFieldVector v, float scayl) {
    pushMatrix();

    stroke(ARROW_COLOR);
    // Draw three lines to make an arrow.
    Vec2D pos = v.position();
    Vec2D scaledForce = v.force().scale(scayl);
    Vec2D arrowTip = pos.add(scaledForce);
    Vec2D arrowEdge = pos.sub(arrowTip).normalizeTo(ARROW_SIZE);
    beginShape();
    // Main shaft of the arrow.
    gfx.line(pos, arrowTip);
    // Two edges of the arrow.
    gfx.line(arrowTip, arrowTip.add(arrowEdge.copy().rotate(0.5235988)));
    gfx.line(arrowTip, arrowTip.add(arrowEdge.copy().rotate(-0.5235988)));
    endShape();
    
    popMatrix();
  }
}
