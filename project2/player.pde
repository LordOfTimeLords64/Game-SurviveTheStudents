/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//player class

//===========================================================================================
class player implements Serializable{
  
  //----------------------------------------------
  //player vars
  PVector pos;
  ArrayList<bullet> bullets;
  enemies e;
  int score = 0, initHealth = 10, health, radius = 35, pic;
  //----------------------------------------------
  
  //----------------------------------------------
  //constructor
  player(PVector xy, enemies badGuys, int p) {
    pos = xy.copy();
    bullets = new ArrayList<bullet>();
    e = badGuys;
    pic = p;
  }
  //----------------------------------------------
  
  //----------------------------------------------
  // player icon motion and display
  //----------------------------------------------
  void move(int x) {
    pos.add(x, 0);
    if(pos.x < radius) pos.x = radius;
    if(pos.x > width-radius) pos.x = width-radius;
    display();
  }
  //----------------------------------------------
  void display() {
    displayProfile(teacherPics[pic], pos.x, pos.y);
  }
  //----------------------------------------------
  
  //----------------------------------------------
  void run() {
    
    //tracking player points
    for(int i = bullets.size() - 1; i >= 0; i--) {
      for( int j = e.enemies.size() - 1; j >= 0; j --) {
        bullet b = bullets.get(i);
        enemy k = e.enemies.get(j);
        if(b.hit(k)) {
          b.kill();
          k.kill();
          score ++;
          pop.play();
          if(score%10 == 0) {
            if(pic == 0) EngelTriumph[floor(random(EngelTriumph.length-0.01))].play();
            else CarlTriumph[floor(random(CarlTriumph.length-0.01))].play();
          }
        }
      }
    }
    
    //removing player missiles
    for(int i = bullets.size() - 1; i >= 0; i--) {
      bullet b = bullets.get(i);
      b.run();
      if(b.isDead()) {
        bullets.remove(i);
      }
    }
    
    //update health and display
    health = initHealth - e.passed;
    display();
    
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //shoot missile method
  void shoot() {
    bullets.add(new bullet(pos, pic));
    woosh.play();
  }
  //----------------------------------------------
  
}//end player class
//===========================================================================================
