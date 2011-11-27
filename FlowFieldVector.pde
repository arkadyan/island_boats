class FlowFieldVector {
  
  import toxi.geom.*;
  import toxi.processing.*;
  
  private Vec2D position;
  private Vec2D force;
  
  
  FlowFieldVector(Vec2D p, Vec2D f) {
    position = p;
    force = f;
  }
  
  
  /**
   * Get the position of this FlowFieldVector.
   */
  public Vec2D position() {
    return position;
  }
  /**
   * Set the position of this FlowFieldVector.
   */
  public void setPosition(Vec2D p) {
    position = p;
  }
  /**
   * Get the force vector of this FlowFieldVector.
   */
  public Vec2D force() {
    return force;
  }
  /**
   * Set the force vector of this FlowFieldVector.
   */
  public void setForce(Vec2D f) {
    force = f;
  }
}
