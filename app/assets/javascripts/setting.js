var txtZip;
var txtNumber;
var txtStreet;
var txtCity;
var txtProvince;
var txtLat;
var txtLng;

function updateLocation() {
    txtZip = document.getElementById("user_preference_zip_code");
    txtNumber = document.getElementById("user_preference_house_number");
    txtStreet = document.getElementById("user_preference_street");
    txtCity = document.getElementById("user_preference_city");
    txtProvince = document.getElementById("user_preference_province");
    txtLat = document.getElementById("user_preference_lat");
    txtLng = document.getElementById("user_preference_lng");
    var lat = txtLat.value;
    var lng = txtLng.value;

    if(lat === "" || lng === "") {
        if(txtZip.value != "" || 
                txtNumber.value != "" || 
                    txtStreet.value != "" || 
                        txtCity.value != "" || 
                            txtProvince.value != "") {
            var address;
            if(txtZip.value != "") {
                address = txtZip.value
            } else {
                address = txtNumber.value + "+" + txtStreet.value + "+" + txtCity.value + "+" + txtProvince.value + "&components=country:CA"; 
            }
            decode( address );
        }
    }
}

function parse( that, index, those) {
    if ( $.inArray('postal_code', that.types) > -1 ) {
        txtZip.value = that.short_name;
    } else if ( $.inArray('street_number', that.types) > -1 ) {
        txtNumber.value = that.short_name;
    } else if ( $.inArray('route', that.types) > -1 ) {
        txtStreet.value = that.short_name;
    } else if ( $.inArray('locality', that.types) > -1 ) {
        txtCity.value = that.short_name;
    } else if ( $.inArray('administrative_area_level_1', that.types) > -1 ) {
        txtProvince.value = that.long_name;
    }

}

function decode( address ) {
    $.getJSON('https://maps.googleapis.com/maps/api/geocode/json?address=' + address + '&key=AIzaSyAwlEaJqSfz_u9jvEdoStjKgNRJiebe0D4&language=en', function(data){
        //console.log(data);
        if(data.status == "OK") {
            // alert(data.results[0].formatted_address);
            var result = data.results[0];
            result.address_components.forEach( parse );
            txtLat.value = result.geometry.location.lat;
            txtLng.value = result.geometry.location.lng;
        }
    });
}

