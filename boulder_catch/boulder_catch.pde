static float difficulty = 1.0;

// difficulty parameters
static int maxBoulders = 10;
static float maxBoulderSpeed = 3.0;
static float minBoulderSpeed = 1.0;
static float boulderCreationProbability = 1;
static float maxBoulderRadius = 50;
static float minBoulderRadius = 10;
static float shipSpeed = 5;

// game board setup parameters
static int canvasWidth;
static int canvasHeight;
static Spaceship ship;
static float shipHeight = 20;
static float shipWidth = 50;
static int score = 0;
static ArrayList<Boulder> boulders;
static PFont font;

public class Boulder {
  public Boulder(float x, float y, float radius, float speed, color c) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    this.speed = speed;
    this.boulderColor = c;
  }
  
  float x;
  float y;
  float radius;
  float speed;
  color boulderColor;
}

public class Spaceship {
  public Spaceship(float x, float width, float height) {
    this.x = x;
    this.width = width;
    this.height = height;
  } 
  
  private boolean pointInShip(float x, float y) {
     return (x >= this.x && x <= this.x + width) && (y >= canvasHeight - height && y <= canvasHeight);   
  }
  
  private boolean edgeInBoulder(float cx, float cy, float radius, float left, float top, float right, float bottom) {
    float closestX = (cx < left ? left : (cx > right ? right : cx));
    float closestY = (cy < top ? top : (cy > bottom ? bottom : cy));
    float dx = closestX - cx;
    float dy = closestY - cy;
    return ( dx * dx + dy * dy ) <= radius * radius;
  }
  
  public boolean collides(Boulder b) {
    float cx = b.x + b.radius;
    float cy = b.y + b.radius;
    
    // check if the center of the circle is inside the ship or if the distance between the closest edge on the rectangle and the boulder's center is less than the radius of the boulder
    return pointInShip(cx, cy) || edgeInBoulder(cx, cy,  b.radius, x, canvasHeight - height, x + width, canvasHeight);         
  }
  
  float x;
  float width;
  float height;
}


void setup() {
  size(600, 600);
  canvasHeight = 600;
  canvasWidth = 600;
  ship = new Spaceship((canvasWidth- shipWidth)/2, shipWidth, shipHeight); 
  boulders = new ArrayList();    
  font = createFont("Merkur.tf", 32);
  textFont(font);
}

float computeScore(float radius) {
  return max(10, 100 - ((radius - minBoulderRadius) / (maxBoulderRadius -  minBoulderRadius) * 100));
}

void draw() {
  background(255);
  
  if (boulders.size() < maxBoulders && random(100.0) < boulderCreationProbability)  {
    boulders.add(new Boulder(random(canvasWidth), 0, random(minBoulderRadius, maxBoulderRadius), random(minBoulderSpeed, maxBoulderSpeed), color(random(255), random(255), random(255))));
  }
  
  // move boulders
  for (int i = 0; i < boulders.size(); i++) {
    Boulder b = boulders.get(i);
    b.y += b.speed;
  }
  
  // draw boulders 
  for (int i = 0; i < boulders.size(); i++) {
    Boulder b = boulders.get(i);
    fill(b.boulderColor);
    ellipse(b.x, b.y, b.radius, b.radius);
  }
  
  // move space ship
  if (keyPressed == true && key == CODED) {
    switch (keyCode) {
      case LEFT:
        ship.x = constrain(ship.x - shipSpeed, 0, canvasWidth - ship.width);
        break;
      case RIGHT:
        ship.x = constrain(ship.x + shipSpeed, 0, canvasWidth - ship.width);
        break;
      default:
        break;
    }
  }
  
  // draw space ship
  fill(0);
  rect(ship.x, canvasHeight - ship.height, ship.width, ship.height);
  
  // remove boulders that are touching the space ship
  for (int i = 0; i < boulders.size(); i++) {
    Boulder b = boulders.get(i);
    boolean collides = ship.collides(b);
    if (collides) {
       System.out.println("we have a collision.");
       boulders.remove(i); 
       score += computeScore(b.radius);
    }
  } 
  
    // remove boulders that have reached the bottom of the canvas
  for (int i = 0; i < boulders.size(); i++) {
    Boulder b = boulders.get(i);
    if (b.y >= canvasHeight) {
      System.out.println("boulder has reached the bottom of the screen.");
      boulders.remove(i);
      score -= computeScore(b.radius);
    }
  }
  
  text("Score : " + Integer.toString(score), 20, 40);
}