class FlowField {
  
  import toxi.geom.*;
  import toxi.processing.*;
  

  private static final color ARROW_COLOR = #cccccc;
  private static final int ARROW_SIZE = 4;
  
  private Vec2D[][] field;   // A flow field is a two-dimensional array of vectors
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
    field = new Vec2D[cols][rows];
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
        float theta = map(noise(xoff, yoff), 0, 1, 0, TWO_PI);
        // Polar to cartesian coordinate transformation to get 
        // x and y components of the vector.
        field[i][j] = new Vec2D(cos(theta), sin(theta));
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
    return field[column][row].copy();
  }
  
  /**
   * Draw every vector as a grid of arrows.
   */
  public void draw(ToxiclibsSupport gfx) {
    for (int i=0; i < cols; i++) {
      for (int j=0; j < rows; j++) {
        drawVector(gfx, field[i][j], i*resolution, j*resolution, resolution-2);
      }
    }
  }
  
  
  /**
   * Renders a vector object as an arrow at a location.
   *
   * @param gfx  The Toxiclibs drawing object.
   * @param v  The vector to be drawn.
   * @param x  The x component of the location to draw the vector.
   * @param y  The y component of the location to draw the vector.
   * @param scayl  How much to scale the drawing of the vector.
   */
  private void drawVector(ToxiclibsSupport gfx, Vec2D v, float x, float y, float scayl) {
    pushMatrix();
    
    // Translate to location to render the vector.
    translate(x, y);
    stroke(ARROW_COLOR);
    // Call vector heading function to get direction
    // (note that pointing up is a heading of 0) and rotate.
    rotate(v.heading());
    // Calculate the length of the vector & scale it to be bigger
    // or smaller as necessary.
    float len = v.magnitude() * scayl;
    
    // Draw three lines to make an arrow (draw pointing up
    // since we've rotated to the proper direction).
    beginShape();
    line(0, 0, len, 0);
    line(len, 0, len-ARROW_SIZE, +ARROW_SIZE/2);
    line(len, 0, len-ARROW_SIZE, -ARROW_SIZE/2);
    endShape();
    
    popMatrix();
  }
}
