var txtZip;
var txtNumber;
var txtStreet;
var txtCity;
var txtProvince;

function updateLocation() {
    txtZip = document.getElementById("zip_code");
    txtNumber = document.getElementById("house_number");
    txtStreet = document.getElementById("street");
    txtCity = document.getElementById("city");
    txtProvince = document.getElementById("province");
    var lat = document.getElementById("lat").innerHTML;
    var lng = document.getElementById("lng").innerHTML;
    
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
            document.getElementById("lat").innerHTML = result.geometry.location.lat;
            document.getElementById("lng").innerHTML = result.geometry.location.lng;
        }
    });
}

