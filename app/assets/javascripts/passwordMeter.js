var password = document.getElementById('password');
var meter = document.getElementById('passwordMeter');

password.addEventListener('input', function(){
  meter.value = password.PasswordStrength();
  
  
});


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