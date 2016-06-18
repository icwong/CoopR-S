//document.getElementById("user_password").addEventListener("keyup",updateMeter);


//document.getElementById("user_password").addEventListener("keyup", updateMeter);
//document.getElementById("user_password").onkeyup = updateMeter;

function updateMeter(){
  //alert("update meter test");
  var score;
  var element = document.getElementById("user_password");
  alert(element);
  score = element.passwordScore();
  alert(score);
  document.getElementById("passwordMeter").value = score;
  
}

function passwordScore(){
  //alert("got here");
    var strength = this.PasswordStrength();
    alert(strength.score);
    return strength.score;
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
