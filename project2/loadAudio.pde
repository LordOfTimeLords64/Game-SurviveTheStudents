/* Retirement Party Game
 * Michael Komnick and Hallie Rutten
 * CSCI 276 Final Project
 * Dec 2022
 */
// Loading profile pictures

//===================================================================================
void loadCarlAudio(){
  
  //----------------------------------------------
  //fetching audio file names and prepping arrays
  CarlPathT = loadFilenames(sketchPath()+"/CarlAudio/success");
  CarlPathS = loadFilenames(sketchPath()+"/CarlAudio/trouble");
  CarlTriumph = new SoundFile[CarlPathT.length];
  CarlSadness = new SoundFile[CarlPathS.length];
  //----------------------------------------------
  
  //----------------------------------------------
  //reading triumphant audio clips
  for(int i=0; i<CarlPathT.length; i++){
    //String path = sketchPath()+"/CarlAudio/success"+CarlPath1[i];
    CarlTriumph[i] = new SoundFile(this, CarlPathT[i]);
    println(CarlPathT[i]);
  }
  //----------------------------------------------
  //reading disappointed audio clips
  //----------------------------------------------
  for(int i=0; i<CarlPathS.length; i++){
    //String path = sketchPath()+"/CarlAudio/trouble"+CarlPath2[i];
    CarlSadness[i] = new SoundFile(this, CarlPathS[i]);
    println(CarlPathS[i]);
  }
  //----------------------------------------------
  
}//end loading Brother Carl audio
//===================================================================================


//===================================================================================
void loadEngelAudio(){
  
  //----------------------------------------------
  // fetching audio file names and prepping arrays
  EngelPathT = loadFilenames(sketchPath()+"/EngelAudio/success");
  EngelPathS = loadFilenames(sketchPath()+"/EngelAudio/trouble");
  EngelTriumph = new SoundFile[EngelPathT.length];
  EngelSadness = new SoundFile[EngelPathS.length];
  //----------------------------------------------
  
  //----------------------------------------------
  //reading triumphant audio clips
  //----------------------------------------------
  for(int i=0; i<EngelPathT.length; i++){
    //String path = sketchPath()+"/EngelAudio/success"+EngelPath1[i];
    EngelTriumph[i] = new SoundFile(this, EngelPathT[i]);
    println(EngelPathT[i]);
  }
  //----------------------------------------------
  //reading disappointed audio clips
  //----------------------------------------------
  for(int i=0; i<EngelPathS.length; i++){
    //String path = sketchPath()+"/EngelAudio/trouble"+EngelPath2[i];
    EngelSadness[i] = new SoundFile(this, EngelPathS[i]);
    println(EngelPathS[i]);
  }
  //----------------------------------------------
  
}//end loading Maestro Engel audio
//===================================================================================
