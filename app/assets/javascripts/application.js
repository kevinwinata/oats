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
	document.getElementById("timer-second").innerHTML = "00";
	document.getElementById("timer-minute").innerHTML = "00";
	document.getElementById("timer-hour").innerHTML = "00";
	interval = setInterval(function() {startCount();}, 1000);
	document.getElementById("checkin").style.visibility = 'hidden';
	document.getElementById("checkout").style.visibility = 'visible';
}

function stop(){
	clearInterval(interval);
	document.getElementById("checkin").style.visibility = 'visible';
	document.getElementById("checkout").style.visibility = 'hidden';
}

function padding(number){
	while(number.length < 2){
			number = '0' + number;
	}

	return number;
}