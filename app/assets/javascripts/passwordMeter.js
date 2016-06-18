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
  document.getElementById("passwordMeter").value = score;
}

function passwordScore(password){
  var result;
  result = zxcvbn(password);
  return result.score;
}

function validatePassword()
{
  var strength = this.PasswordStrength();
  if(strength.isValid("good"))
  { 
    return true;
  }else{
    alert("password is too weak");
    window.history.back();
    return false;
  }
}
