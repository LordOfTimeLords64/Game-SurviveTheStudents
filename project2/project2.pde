/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
//Main Game

//===========================================================================================
//libraries
import processing.net.*;
import java.io.*;
import processing.sound.*;

//preparation to load content
String[] studentFiles, teacherFiles;
PImage[] studentPics, teacherPics;
int studentR=60, teacherR=70, missileR=30;
PImage F, B;
String[] CarlPathT, CarlPathS, EngelPathT, EngelPathS;
SoundFile[] CarlTriumph, CarlSadness, EngelTriumph, EngelSadness;
SoundFile backTrack, woosh, pop;

//background prep
stars backrnd;

//prep for entities
player p1, p2;
enemies npcs;
int p1Move, p2Move, speed = 10, startMils, mils = 0, sec, min, enemySpeed, playerNum = 1;
float prob = .01;

//game states
boolean gameOver,
  spGameStart = false,
  mpHostStart = false,
  mpClientStart = false,
  mpB = false,
  spSetup = false,
  mpSetup = false;

//menu buttons
button join, host; //, sp, mp;
button carl, engel;

//multiplayer (pending feature)
String ip = "";
byte input[];
Server s;
Client c;
//===========================================================================================


//===========================================================================================
void setup() {
  //----------------------------------------------
  //basic environment
  size(700, 700);
  frameRate(60);
  textAlign(CENTER, CENTER);
  //stars in the backround (lovely)
  backrnd = new stars();
  for(int i = int(random(50, 75)); i >= 0; i--) {
    backrnd.addStar(new PVector(random(5, width-5), random(5, height-5)), new PVector(0, random(1, 2)));
  }
  //----------------------------------------------
  
  //----------------------------------------------
  // loading audio content
  backTrack = new SoundFile(this, "backTrack.wav");
  woosh = new SoundFile(this, "woosh.wav");
  pop = new SoundFile(this, "pop.wav");
  backTrack.amp(.05);
  backTrack.loop();
  loadCarlAudio();
  loadEngelAudio();
  //----------------------------------------------
  
  //----------------------------------------------
  // loading visual content
  loadMissiles();
  loadStudents();
  loadTeachers();
  //----------------------------------------------
  
  //----------------------------------------------
  // menu buttons
  //----------------------------------------------
  //experimental multiplayer (pending feture)
  // sp = new button(width/4, height/2, 250, 50, "Single Player");
  // mp = new button(3*width/4, height/2, 250, 50, "Multiplayer");
  host = new button(width/2, height/4, 250, 50, "Host");
  join = new button(width/2, 3*height/4, 250, 50, "Join");
  
  // character selection
  carl = new button(width/4, height/2, 250, 50, "Brother Carl");
  engel = new button(3*width/4, height/2, 250, 50, "Maestro Engel");
  //----------------------------------------------
  
}//end setup
//===========================================================================================


//===========================================================================================
void draw() {
  //----------------------------------------------
  //background
  background(0);
  backrnd.run();
  //----------------------------------------------
  
  //----------------------------------------------
  // Main menu screen
  if(!spGameStart && !gameOver && !mpB) {
    //experimental multiplayer (pending feature)
    // sp.run(); // Single Player button
    // mp.run(); // Multiplayer button
    
    //button updates
    carl.run(); // Carl button
    engel.run(); // Engel button
    
    //character selection
    if(mousePressed == true) {
      //experimental multiplayer (pending feature)
      // if(sp.isHovered()) spGameStart = true;
      // if(mp.isHovered()) mpB = true;
      if(carl.isHovered()) {
        spGameStart = true;
        playerNum = 1;
      }
      if(engel.isHovered()) {
        spGameStart = true;
        playerNum = 0;
      }
    }
    
    //high score display
    String [] highScores = loadStrings("highScores.txt");
    int highScore = int(highScores[0]);
    text("High Score: " + highScore, width/2, height/4);
    
    //keeping the clock relative to start time
    startMils = millis(); // Clock start offset
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //run singleplayer game
  //----------------------------------------------
  // If single player is started and the game isn't over
  if(!gameOver && spGameStart) {
    spRun(); // Jump to single player code
  }
  //----------------------------------------------
  
  //----------------------------------------------
  //multiplayer selection screen (pending feature)
  //----------------------------------------------
  // If multiplayer is selected and the game isn't over
  if(!gameOver && mpB && !mpHostStart && !mpClientStart) {
    host.run(); // Host button
    join.run(); // Join button
    text("Type the Host's IP: ", width/2, height/2);
    text("IP: " + ip, width/2, height/2+50);
    if(mousePressed == true) {
      if(host.isHovered()) {
        mpHostStart = true;
      }
      else if(join.isHovered()) {
        connect();
        mpClientStart = true;
      }
    }
    startMils = millis(); // Clock start offset
  }
  //----------------------------------------------
  //start multiplayer host (pending feature)
  //----------------------------------------------
  // If multiplayer host is selecteed and the game isn't over
  if(!gameOver && mpHostStart) {
    mpHostRun();
  }
  //----------------------------------------------
  //start multiplayer client (pending feature)
  //----------------------------------------------
  // If multiplayer client is selected and the game isn't over
  if(!gameOver && mpClientStart) {
    mpClientRun();
  }
  //----------------------------------------------
  
  //----------------------------------------------
  // Game Over proceedure
  //----------------------------------------------
  if(gameOver) {
    
    //dealing with scores and highscores
    int score = 0, highScore = 0;
    if(mpClientStart) score = p2.score; 
    else score = p1.score;
    String [] scores = {str(score)};
    String [] oldHighScore = loadStrings("highScores.txt");
    if(int(oldHighScore[0]) < score) {
      saveStrings("data/highScores.txt", scores);
      highScore = score;
    } else highScore = int(oldHighScore[0]);
    
    //displaying scores
    fill(0, 0, 160);
    rectMode(CENTER);
    rect(width/2, height/2, width, 300);
    textSize(90);
    textAlign(CENTER, CENTER);
    fill(255);
    text("GAME OVER!", width/2, height/2 - 75);
    text("Score: " + score, width/2, height/2 + 50);
  }
  //----------------------------------------------
  
}//end draw
//===========================================================================================


//===========================================================================================
// Setup required for single players
void setupSP() {
  npcs = new enemies();
  p1 = new player(new PVector(width/2, height - 50), npcs, playerNum);
}
//===========================================================================================


//===========================================================================================
// Singleplayer code
void spRun() {
  // Run setup if it hasn't been already
  if(!spSetup) {
    setupSP();
    spSetup = true;
  }
  
  textAlign(CENTER, CENTER);
  
  // Clock
  mils = millis() - startMils;
  
  // Time conversion
  min = (mils/1000)/60;
  sec = (mils/1000)%60;
  
  // Probability of enemies spawning
  if(mils%20000 == 0 && prob < 1) prob += .05;
  
  // Enemy speed increases incrementally
  enemySpeed = (min*3+sec/20+1)*2;
  enemySpeed = min(enemySpeed, 10);
  
  // Enemies
  if(random(0, 1) <= prob) {
    npcs.addEnemy(new PVector(random(25, width-25), -50), new PVector(0, enemySpeed));
  }
  
  p1.move(p1Move);
  p1.run();
  npcs.run();
  
  // Text info display
  fill(255);
  textSize(30);
  text("Health: " + p1.health, width/2, 60);
  text("Time: " + nf(min, 2) + ":" + nf(sec, 2), width/2, 30);
  text("Score: " + p1.score, width/2, 90);
  
  // Game over condition
  if(p1.health <= 0) gameOver = true;
  
}//end singleplayer code
//===========================================================================================


//===========================================================================================
// Setup required to host a multiplayer game (pending feature)
void setupMP() {
  npcs = new enemies();
  p1 = new player(new PVector(width/4, height - 50), npcs, 1);
  p2 = new player(new PVector(3*width/4, height - 50), npcs, 0);
}
//===========================================================================================


//===========================================================================================
//multiplyer host code (pending feature)
void mpHostRun() {
  if(!mpSetup) {
    startServer();
    setupMP();
    mpSetup = true;
  }
  
  textAlign(CENTER, CENTER);
  
  // Clock
  mils = millis() - startMils;
  
  // Time conversion
  min = (mils/1000)/60;
  sec = (mils/1000)%60;  
  
  // Probability of enemies spawning
  if(mils%20000 == 0 && prob < 1) prob += .05;
  
  // Enemy speed increases incrementally
  enemySpeed = (min*3+sec/20+1)*2;
  enemySpeed = min(enemySpeed, 10);
  
  // Enemies
  if(random(0, 1) <= prob) {
    npcs.addEnemy(new PVector(random(25, width-25), -50), new PVector(0, enemySpeed));
  }
  
  p1.move(p1Move);
  p1.run();
 
  // s.write(p1Move + "," + p1Shot);
  try {
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ObjectOutputStream oos = new ObjectOutputStream(baos);
    oos.writeObject(p1);
    oos.close();
    byte[] bytes = baos.toByteArray();
    baos.close();
    s.write(bytes);
  } catch (Exception e) {
    println(e.getMessage());
    println(e.toString());
    e.printStackTrace();
    println("host send");
  }
  
  // Player 2 (Client Connection) Receive shots and movements
  c = s.available();
  if(c != null) {
    input = c.readBytes();
    try {
      ByteArrayInputStream bais = new ByteArrayInputStream(input);
      ObjectInputStream ois = new ObjectInputStream(bais);
      p2 = (player)ois.readObject();
      ois.close();
      bais.close();
    } catch(Exception e) {
      println(e.getMessage());
      println("host receive");
    }
  }
  p2.run();
  
  npcs.run();
  
  // Text info display
  fill(255);
  textSize(25);
  text("Health: " + p1.health, width/2, 60);
  text("Time: " + nf(min, 2) + ":" + nf(sec, 2), width/2, 30);
  textAlign(CORNER);
  text("Score: " + p1.score, 10, height-100);
  
  // Game over condition
  if(p1.health <= 0) gameOver = true;
  
}//end multiplayer host code
//===========================================================================================


//===========================================================================================
//multiplayer client code (pending feature)
void mpClientRun() {
  if(!mpSetup) {
    setupMP();
    mpSetup = true;
  }
  
  textAlign(CENTER, CENTER);
  
  // Clock
  mils = millis() - startMils;
  
  // Time conversion
  min = (mils/1000)/60;
  sec = (mils/1000)%60;
  
  // Probability of enemies spawning
  if(mils%20000 == 0 && prob < 1) prob += .05;
  
  // Enemy speed increases incrementally
  enemySpeed = (min*3+sec/20+1)*2;
  enemySpeed = min(enemySpeed, 10);
  
  p2.move(p2Move);
  p2.run();
  
  // c.write(p2Move + "," + p2Shot);
  
  try {
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ObjectOutputStream oos = new ObjectOutputStream(baos);
    oos.writeObject(p2);
    oos.close();
    byte[] bytes = baos.toByteArray();
    baos.close();
    s.write(bytes);
  } catch (Exception e) {
    println(e.getMessage());
  }
  
  // Player 1 (Server Connection) Receive shots and movements
  if(c.available() > 0) {
    input = c.readBytes();
    try {
      ByteArrayInputStream bais = new ByteArrayInputStream(input);
      ObjectInputStream ois = new ObjectInputStream(bais);
      p1 = (player)ois.readObject();
      ois.close();
      bais.close();
      npcs = p1.e;
    } catch(Exception e) {
      println(e.getMessage());
    }
  }
  
  p1.run();
  
  npcs.run();
  
  // Text info display
  fill(255);
  textSize(25);
  text("Health: " + p1.health, width/2, 60);
  text("Time: " + nf(min, 2) + ":" + nf(sec, 2), width/2, 30);
  textAlign(CORNER);
  text("Score: " + p1.score, 10, height-100);
  
  // Game over condition
  if(p1.health <= 0) gameOver = true;
  
}//end multiplayer client code
//===========================================================================================


//===========================================================================================
// player controls
void keyPressed() {
  
  //motion controls
  if(key == CODED) {
    if(keyCode == LEFT) {
      if(spGameStart || mpHostStart) p1Move = -(speed);
      else if (mpClientStart) p2Move = -(speed);
    }
    if(keyCode == RIGHT) {
      if(spGameStart || mpHostStart) p1Move = speed;
      else if (mpClientStart) p2Move = speed;
    }
  }
  
  //pew pew shooty code
  if(key == ' ') {
    if(spGameStart || mpHostStart) {
      p1.shoot();
    }
    else if (mpClientStart) p2.shoot();
  }
  
  //backspace for IP typing (multiplayer pending feature)
  if(mpB) {
    if(key == BACKSPACE || key == DELETE) {
      if(ip.length() > 0) ip = ip.substring(0, ip.length()-1);
    } else {
      ip = ip + key;
    }
  }
  
}//end player controls
//===========================================================================================


//===========================================================================================
//extended player controls
void keyReleased() {
  
  //if player is not pressing motion keys, velocity reduced to 0
  if(key == CODED) {
    if(keyCode == LEFT) {
      if((spGameStart || mpHostStart) && p1Move == -(speed)) p1Move = 0;
      else if(mpClientStart && p2Move == -(speed)) p2Move = 0;
    }
    if(keyCode == RIGHT) {
      if((spGameStart || mpHostStart) && p1Move == speed) p1Move = 0;
      else if(mpClientStart && p2Move == speed) p2Move = 0;
    }
  }
  
}//end extended controls
//===========================================================================================


//===========================================================================================
//multiplyer connections (pending feature)
void connect() {
  c = new Client(this, ip, 9000);
}
void startServer() {
  s = new Server(this, 9000);
}
//===========================================================================================


//===========================================================================================
//reading file names for loading proceedures
String[] loadFilenames(String path) {
  File folder = new File(path);
  return folder.list();
}
//===========================================================================================


//===========================================================================================
//sad noise for escaped students
void playSad() {
  
  if(mpClientStart) {
    if(p2.pic == 0) EngelSadness[floor(random(EngelSadness.length-0.01))].play();
    else CarlSadness[floor(random(CarlSadness.length-0.01))].play();
  } else {
    if(p1.pic == 0) EngelSadness[floor(random(EngelSadness.length-0.01))].play();
    else CarlSadness[floor(random(CarlSadness.length-0.01))].play();
  }
  
}//end sad noise
//===========================================================================================
