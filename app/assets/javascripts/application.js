// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree 
//= require bootstrap-datetimepicker

var interval;

function startCount(){
	var second = parseInt(document.getElementById("timer-second").innerHTML, 10);

	var minute = parseInt(document.getElementById("timer-minute").innerHTML, 10);
	var hour = parseInt(document.getElementById("timer-hour").innerHTML, 10);
	if (second < 59){
		second++;
	} else{
		second = 0;
		if (minute < 59) {
			minute++;
		}else{
			minute = 0;
			if (hour < 59) {
				hour++;
			}
		}
	}

	document.getElementById("timer-second").innerHTML = padding(second.toString());
	document.getElementById("timer-minute").innerHTML = padding(minute.toString());
	document.getElementById("timer-hour").innerHTML = padding(hour.toString());
}

function start(){
	interval = setInterval(function() {startCount();}, 1000);
}

function stop(){
	clearInterval(interval);
}

function padding(number){
	while(number.length < 2){
			number = '0' + number;
	}

	return number;
}

function popUp(){
	document.getElementById("popup_window").style.opacity = "1";
	document.getElementById("popup_window").style.zIndex = 5;
}

function close_popup(){
	document.getElementById("popup_window").style.opacity = "0";
	document.getElementById("popup_window").style.zIndex = -5;
}

function checkDate(){
	var date_from = document.getElementById("datefrom").value;
	var date_to = document.getElementById("dateto").value;
	var dmy_from;
	var dmy_to;
	var f;
	var t;

			//element[0] = date, element[1] = month, elemen[2] = year
			dmy_from = date_from.split("/");
			dmy_to = date_to.split("/");

			f = new Date();
			f.setFullYear(dmy_from[2], parseInt(dmy_from[1])-1, dmy_from[0]);

			t = new Date();
			t.setFullYear(dmy_to[2], parseInt(dmy_to[1])-1, dmy_to[0]);

	if (f > t){
		alert("Wrong input! End Date must be the same date or after the Start Date!");
		return false;
	}
	return true;
}



/*
var _latitude;
var _longitude;


function showPosition(position)
{
	alert(position);
  	_latitude = position.coords.latitude;
  	_longitude = position.coords.longitude;	

	alert(method + action + position.coords.latitude + position.coords.longitude);
}		

function getLocation()
  {
  if (navigator.geolocation)
    {
    navigator.geolocation.getCurrentPosition(showPosition);
    }
  else{x.innerHTML="Geolocation is not supported by this browser.";}
  }

function postLocation(method, action)
{

  	alert(method + action + _latitude + _longitude);

  	alert(_latitude);
  	alert(_longitude);

  	var form = document.createElement("form");
  	form.setAttribute("method", method);
  	form.setAttribute("action", action);

	var latiField = document.createElement("input");
	latiField.setAttribute("type", "hidden");
	latiField.setAttribute("name", "latitude");
	latiField.setAttribute("value", _latitude);

	form.appendChild(latiField);

	var longField = document.createElement("input");
	latiField.setAttribute("type", "hidden");
	latiField.setAttribute("name", "longitude");
	latiField.setAttribute("value", _longitude);
	form.appendChild(longField);

    document.body.appendChild(form);
    form.submit();
}
*/

/*function postLocation(method, action)
{
	var nav = null;
	var latitude;
	var longitude;

	function requestPosition() {
	if (nav == null) {
	nav = window.navigator;
	}

	var geoloc = nav.geolocation;
	if (geoloc != null) {
	geoloc.getCurrentPosition(successCallback, errorCallback);
	}

	}

	function successCallback(position) {
	//alert(position.coords.latitude +" "+ position.coords.longitude);
		latitude = position.coords.latitude;
		longitude = position.coords.longitude;
		alert(latitude + " , " +longitude);
	}

	function errorCallback(error) {
		var strMessage = "";

		// Check for known errors
		switch (error.code) {
		case error.PERMISSION_DENIED:
		strMessage = "Access to your location is turned off. " +
		"Change your settings to turn it back on.";
		break;
		case error.POSITION_UNAVAILABLE:
		strMessage = "Data from location services is " +
		"currently unavailable.";
		break;
		case error.TIMEOUT:
		strMessage = "Location could not be determined " +
		"within a specified timeout period.";
		break;
		default:
		break;
		}

		alert(strMessage);
	}

	var form = document.createElement("form");
  	form.setAttribute("method", "POST");
  	form.setAttribute("action", action);

	var latiField = document.createElement("input");
	latiField.setAttribute("type", "hidden");
	latiField.setAttribute("name", "latitude");
	latiField.setAttribute("value", latitude);

	form.appendChild(latiField);

	var longField = document.createElement("input");
	latiField.setAttribute("type", "hidden");
	latiField.setAttribute("name", "longitude");
	latiField.setAttribute("value", longitude);
	form.appendChild(longField);

    document.body.appendChild(form);
    form.submit();
}*/