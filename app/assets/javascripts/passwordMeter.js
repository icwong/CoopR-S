//document.getElementById("user_password").addEventListener("keyup",updateMeter);


//document.getElementById("user_password").addEventListener("keyup", updateMeter);
//document.getElementById("user_password").onkeyup = updateMeter;

function updateMeter(){
  var score;
  var password;
  password = document.getElementById("user_password").value;
  //score the password
  score = passwordScore(password);
  
  //update meter with score
  //document.getElementById("passwordMeter").value = score;
  
  //update meter with score and colors
  document.getElementById("passwordMeter").style.width = score*100/4 + '%';
  document.getElementById("meterText").innerHTML = score;
  if(score >= 2)  document.getElementById("passwordMeter").style.background = "#00FF00";
  else if( score = 1) document.getElementById("passwordMeter").style.background = "yellow";

}



function passwordScore(password){
  var result;
  result = zxcvbn(password);
  return result.score;
}

function validatePassword(password)
{
  var result = zxcvbn(password)
  if(result.score >= 3)
  { 
    return true;
  }else{
    alert("password is too weak");
    window.history.back();
    return false;
  }
}
