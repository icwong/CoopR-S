function passwordScore(){
    var strength = this.PasswordStrength();
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