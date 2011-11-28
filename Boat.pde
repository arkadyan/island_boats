class Boat extends Mover {
  
  import toxi.geom.*;
  import toxi.processing.*;
  
  
  private static final color BOAT_FILL_COLOR = #aaaaaa;
  private static final color BOAT_STROKE_COLOR = #000000;
  private static final int BOAT_LENGTH = 50;
  private static final int BOAT_WIDTH = 23;
  
  
  /**
   * Creates a new boat, positioned at the given location.
   *
   * @param pos  The position to start at.
   * @param ms  The maximum speed this boat should travel at.
   */
  Boat(Vec2D pos, float ms) {
    position = new Vec2D(pos);
    maxSpeed = ms;
    velocity = new Vec2D(maxSpeed, 0);
    
    acceleration = new Vec2D(0, 0);
    maxForce = 0.1;
  }
  
  
  /**
   * Draw our boat at its current position.
   *
   * @param gfx  A ToxiclibsSupport object to use for drawing.
   * @param debug  Whether on not to draw debugging visuals.
   */
  public void draw(ToxiclibsSupport gfx, boolean debug) {
    // Since it is drawn pointing up, we rotate it an additional 90 degrees.
    float theta = velocity.heading() - PI/2;
    
    stroke(BOAT_STROKE_COLOR);
    fill(BOAT_FILL_COLOR);
    
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    
    beginShape();
    // Stern
    vertex(-0.5*BOAT_WIDTH, +0.3*BOAT_LENGTH);
    vertex(-0.5*BOAT_WIDTH, -0.5*BOAT_LENGTH);
    vertex(+0.5*BOAT_WIDTH, -0.5*BOAT_LENGTH);
    vertex(+0.5*BOAT_WIDTH, +0.3*BOAT_LENGTH);    
    // Bow
    vertex(0, +0.5*BOAT_LENGTH);
    endShape(CLOSE);
    popMatrix();
    
    if (debug) drawDebugVisuals(gfx);
  }
  
  
  /**
   * Draw extra visuals useful for debugging purposes.
   */
  private void drawDebugVisuals(ToxiclibsSupport gfx) {
    // Draw the boat's velocity
    stroke(#ff00ff);
    fill(#ff00ff);
    gfx.line(position, position.add(velocity));
/*    gfx.ellipse(new Ellipse(predictedPosition, 4));*/
  }
}
