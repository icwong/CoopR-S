// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require zxcvbn


/////////////////////

var LAST_LOCATION = "lastUrl";
var CURR_LOCATION = "currUrl";

var JOB_ONE = "j1";
var JOB_TWO = "j2";

function swapClass(clsA, clsB) {
    var temp = clsA.className;
    clsA.className = clsB.className;
    clsB.className = temp;
    if(clsA.disabled || clsB.disabled) {
        if( clsA.disabled ) {
            clsA.disabled = false;
            clsB.disabled = true;
        } else {
            clsB.disabled = false;
            clsA.disabled = true;
        }
    }
}

function switchTab() {
    var clsA = document.getElementById("revCaption");
    var clsB = document.getElementById("proCaption");
    swapClass(clsA, clsB);

    clsA = document.getElementById("revTable");
    clsB = document.getElementById("proTable");
    swapClass(clsA, clsB);
}

function rememberUrl() {
    var oldUrl = getCookie( CURR_LOCATION );
    var fIndex = document.cookie.indexOf(LAST_LOCATION);
    var tIndex = document.cookie.indexOf(";", fIndex + LAST_LOCATION.length + 1); // 1 for "="
    var front = document.cookie.substring(0, fIndex ) + LAST_LOCATION + "="; // compatible with init
    var tail = "";
    
    if(tIndex >= 0) {
        tail = document.cookie.substring(tIndex)
    };
    document.cookie = front + oldUrl + tail;
}

function updateUrl() {
    var newUrl = window.location.href;
	if( document.cookie.indexOf(CURR_LOCATION) >= 0 ) {
        var oldUrl = getCookie( CURR_LOCATION );
        

        if(oldUrl != newUrl) {
            var fIndex = document.cookie.indexOf(LAST_LOCATION);
            var tIndex = document.cookie.indexOf(";", fIndex + LAST_LOCATION.length + 1); // 1 for "="

            var front = document.cookie.substring(0, fIndex ) + LAST_LOCATION + "="; // compatible with init
            var tail = "";
            if(tIndex >= 0) {
                tail = document.cookie.substring(tIndex)
            };
            document.cookie = front + oldUrl + tail;
        }
	} else {
        document.cookie = LAST_LOCATION + "=" + newUrl + ";" + document.cookie;
    }

    document.cookie = CURR_LOCATION + "=" + newUrl + ";" + document.cookie;
};

function lastUrl() {
    var newUrl = getCookie(LAST_LOCATION);
    if(newUrl != window.location.href) {
        window.location.href = newUrl;
    }
}

function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
}

function clearCompareList() {
    document.cookie = JOB_ONE + "=" + ";";
    document.cookie = JOB_TWO + "=" + ";";
    isComparable();
}

function addToCompareList( pid ) {
    var jone = getCookie( JOB_ONE );
    var jtwo = getCookie( JOB_TWO );

    if( pid == JOB_ONE || pid == JOB_TWO) {
        window.alert("yeah");
    }

    if( jone == "" ) {
        document.cookie =   JOB_ONE + "=" + pid + ";";
    } else {
        if ( temp != pid ) {
            temp = getCookie( JOB_TWO );
            if( temp == "" ) {
                document.cookie = JOB_TWO + "=" + pid + ";";
            }   else {
                window.alert("Comparison list is full; remove items before adding a new one.");
            }
        } 
        isComparable();
    }
}

function isComparable() {
    var me = document.getElementById('btnCompare');
    if( null !== me ) {
        if( getCookie( JOB_TWO ) == "") {
            me.disabled = true;
        } else {
            me.disabled = false;
        }
    }
}

function compare() {
    window.location.href = "/compare?j1=" + getCookie( JOB_ONE ) + '&j2=' + getCookie( JOB_TWO );
    // $.ajax({
    //     type: 'get',
    //     url:"compare",
    //     data:'j1=' + getCookie( JOB_ONE ) + '&j2=' + getCookie( JOB_TWO ),
    //     cache:false,
    //     success:function (data) {
    //     },
    //     error: function (data) {
    //     }
    // })
}

function toggleAction() {
    var btnAction = document.getElementById('maction');
    var btnMUser = document.getElementById('muser');
    var btnMPost = document.getElementById('mpost');
    var btnMNP = document.getElementById('wrtpost');

    if( btnAction.className.indexOf("toggled") >= 0 ) {
        btnAction.className = btnAction.className.replace(" toggled", "");
        btnMUser.className = btnMUser.className + " hidden";
        btnMPost.className = btnMPost.className + " hidden";
        btnMNP.className = btnMNP.className.replace(" hidden", "");
    } else {
        btnAction.className = btnAction.className + " toggled";
        btnMUser.className = btnMUser.className.replace(" hidden", "");
        btnMPost.className = btnMPost.className.replace(" hidden", "");
        btnMNP.className = btnMNP.className + " hidden";
    }
}

/*-----------------------SIDEBAR OPEN&CLOSE-------------------------*/
var count = 0;


/* Set the width of the side navigation to 250px and the left margin of the page content to 250px and add a black background color to body */
function openNav() {
    document.getElementById("mySidenav").style.width = "260px";
    document.getElementById("main1").style.marginLeft = "260px";
    document.getElementById("main2").style.marginLeft = "260px";
    

}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("main1").style.marginLeft = "0";
    document.getElementById("main2").style.marginLeft = "0";

}
function OpenCloseNav(){
    
    if(count%2==0){
        openNav();
    }else{
        closeNav();
    }
    count++;
}

function myFunction(x) {
    x.classList.toggle("change");
}

/*=======================slide================*/

/*==============Go-Top=========================*/

    $(document).ready(function(){
            $(window).scroll(function(){
                if($(this).scrollTop() > 200){
                  $('.go-top').fadeIn(200);
                }else{
                  $('.go-top').fadeOut(200);
                }
              });
              $('.go-top').click(function(event){
                event.preventDefault();
                $('html,body').animate({scrollTop: 0}, 300);
             });
 });
