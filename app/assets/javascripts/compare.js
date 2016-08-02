var j1Day;
var j1Hrs;
var j1Sly;
var j2Day;
var j2Hrs;
var j2Sly;

window.onload = function( that ) {
    j1Day = document.getElementById("j1d");
    j1Hrs = document.getElementById("j1h");
    j1Sly = document.getElementById("j1s");
    j2Day = document.getElementById("j2d");
    j2Hrs = document.getElementById("j2h");
    j2Sly = document.getElementById("j2s");
    advise();
}


function advise() {
    judge( j1Day, j2Day, -1);
    judge( j1Hrs, j2Hrs, -1);
    judge( j1Sly, j2Sly, 1);    
}

function judge( thee, that, pos) {
    if ( thee.innerHTML != "" && that.innerHTML != "" ) {
        if ( thee.innerHTML * pos > that.innerHTML * pos ) {
            thee.style.backgroundColor = "GreenYellow";
            that.style.backgroundColor = "LightCoral";
        } else if ( thee.innerHTML * pos < that.innerHTML * pos ) {
            thee.style.backgroundColor = "LightCoral";
            that.style.backgroundColor = "GreenYellow";
        }
    }
}

