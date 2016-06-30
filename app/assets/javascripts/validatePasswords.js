//document.getElementById("user_password").onkeyup = validatePassword();

function updateMeter(score){
  /*
  var score;
  var password;
  password = document.getElementById("user_password").value;
  //score the password
  score = passwordScore(password);
*/

  //update meter with score and colors
  document.getElementById("passwordMeter").style.width = score*100/4 + '%';
  document.getElementById("meterText").innerHTML = score;
  if(score >= 2)  document.getElementById("passwordMeter").style.background = "#00FF00";
  else if( score <= 1) document.getElementById("passwordMeter").style.background = "yellow";
}


function passwordScore(){
  var password = document.getElementById("user_password").value;
  var result;
  result = zxcvbn(password);
  return result.score;
}

function validatePassword()
{
  var score;
  var password;
  password = document.getElementById("user_password").value;
  //score the password
  score = passwordScore(password);
  
  updateMeter(score);
  
  if(password.length >= 6)
  {
    if(score < 2){
     document.getElementById("user_password").valid = false;
    }else document.getElementById("user_password").valid = true;
  }else document.getElementById("user_password").valid = false;
  
  //alert(document.getElementById("user_password").valid);
  
  if(document.getElementById("user_password").valid == false){
    document.getElementById("user_password").style.borderColor = red;
  }else{
    
  }
}

function passwordsMatch() {
  var password;
  var passwordConfirmation;
  password = document.getElementById("user_password").value;
  passwordConfirmation = document.getElementById("user_password_confirmation").value;
  
  if(password == passwordConfirmation){
    return true;
  }else return false;
}
