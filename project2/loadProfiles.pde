/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
// Loading profile and missile pictures

//===================================================================================
void loadStudents(){
  
  //----------------------------------------------
  // fetch file names and prep array
  //----------------------------------------------
  studentFiles = loadFilenames(sketchPath()+"/students");   
  studentPics = new PImage[studentFiles.length];
  //----------------------------------------------
  // load in pictures
  //----------------------------------------------
  for(int i=0; i<studentFiles.length; i++){
    studentPics[i] = loadImage(sketchPath()+"/students/"+studentFiles[i]);
    println(sketchPath()+"/students/"+studentFiles[i]);
    studentPics[i].resize(studentR,studentR);
  }
  //----------------------------------------------
  
}//end loading student icons
//===================================================================================

//===================================================================================
void loadTeachers(){
  
  //----------------------------------------------
  // fetch file names and prep array
  //----------------------------------------------
  teacherFiles = loadFilenames(sketchPath()+"/teachers");
  teacherPics = new PImage[teacherFiles.length];
  //----------------------------------------------
  // load in pictures
  //----------------------------------------------
  for(int i=0; i<teacherFiles.length; i++){
    teacherPics[i] = loadImage(sketchPath()+"/teachers/"+teacherFiles[i]);
    println(sketchPath()+"/teachers/"+teacherFiles[i]);
    teacherPics[i].resize(teacherR,teacherR);
  }
  //----------------------------------------------
  
}//end loading teacher icons
//===================================================================================

//===================================================================================
void loadMissiles(){
  
  //----------------------------------------------
  //load missile pictures
  //----------------------------------------------
  F = loadImage(sketchPath()+"/projectiles/RedF.png");
  B = loadImage(sketchPath()+"/projectiles/Banana.png");
  //----------------------------------------------
  // resize pictures
  //----------------------------------------------
  F.resize(missileR,missileR);
  B.resize(missileR,missileR);
  //----------------------------------------------
  
}//end loading missile pictures
//===================================================================================
