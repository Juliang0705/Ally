// :Mom/s+sy .`:yy` od m+do+hm:dho`mhms`+ho:M +d `Ny  -M`yyhdos:Ms/:mhms .M.odohys/N hom:       
// \:N:hhh +d/N/h/d/ +d/m:d+`md dy/:m/+h/y/N/N +d  d+  .N/hoho  -N///d`ms .N+ysdoom/N.N/yy       
// ./::/:-.--` -+:` `--..:``:-..:/::` -`.---:.-:.`.`   `-.`::.--/:-.. ...-/+:`/-.-`-`-..:       
// .++osoyhho` :yo:   .:/: /o:- /so/      /++/+oss/.      /+/osooo/-    oyyys +sy/   ///.       
// .+os``.shh+ :hso   -:/- /ho: /o+/      ooo:``:oo+      +ys+``.oso.  .ssydh.`sys- :s:-        
// .syy   /ss+ -yso   /+y/ .+so :+s/      ooy-   o++-     +ys/   oso:  /ss.sy/ .ydy.hhs         
// .syy:/+o+o. :os/   :oo+ -+// /os/      yyy:   yso.     :+s/   yhs/ `os+ oss` +ddhmd-         
// -ssyoosyo:` -/ss   -+// :oyo :ss:      ++o-   ooy.     +os/   sdh/ -ss: -oy:  smmd+          
// -yyy```:sys :s+o   -+o+ :sh/ :os+      +yy:   ysy.     /os+   +yh+ sys+/+hs/  -ydm`          
// -ssy   .yo+`:++/   -/+/ +oyo -oo/      yyy-   o/+.     +oo/   oss:.y++oo++/o. -ody           
// -ssh---//:- .o/+.../os- :yo/ /so/`--.- sss-``-///      /++/.`-ssy./so-`  -:/: -ssy           
// -yhoydh+/-   ./osoos/-  :+o+ :oo++++o+ syso+yo+:       /o//+oo+/. hhs.   .yho :dhh 

// TODO:
// make it look pretty
// make better use of templating
// celebrate more wins, more successes, bless up

'use strict';

var express = require('express');
var bodyParser = require('body-parser');
var firebase = require('firebase');

var ref = new Firebase('https://sizzling-heat-3815.firebaseio.com');

var app = express();

// sets up jade for express
app.set('view engine', 'jade');
app.set('views', __dirname + '/templates');
app.use(bodyParser.urlencoded({extended: true}));
app.use('/static',express.static(__dirname + '/public'));

// route
app.get('/', function(req, res) {
	// send data to the client
	res.render('index');
});

var availability = 0;
var long = 0;
var lat = 0;

///////// ALLY SUBMISSION ////////////
app.post('/ally-success', function(req, res) {
	console.log("ally submitted form");
	console.dir(req.body);
	// data from form
	var name = req.body.name;
	var email = req.body.email;
	var password = req.body.password;
	var office = req.body.office;
	var phone = req.body.phone;

	// create new user
	var allyRef = ref.child("ally");
	allyRef.createUser({
		email: email,
		password: password
	}, function(error, userData) {
  	if (error) {
  		printError(error);
 	} 
 	else {
    	console.log("Successfully created user account with uid:", userData.uid);
    	var uid = userData.uid;
    	// submit this to firebase
    	console.log(uid);
    	var data = {};
    	data[uid] = {
					name: name,
					email: email,
					office: office,
					phone: phone,
					availability: availability,
					longitude: long,
					latitude: lat,
					};

    	allyRef.update(data); 
  	}
	});

	// display success message
	res.render('success');
});

///////// USER SUBMISSION ////////////
app.post('/user-success', function(req, res) {
	console.log("user submitted form");
	console.dir(req.body);
	// data from form
	var email = req.body.email;
	var password = req.body.password;
	var phone = req.body.phone;

	// submit this to firebase
	var userRef = ref.child("user");
	userRef.createUser({
		email: email,
		password: password
	}, function(error, userData) {
  	if (error) {
  		printErrors(error);

 	 } 
 	 else {
    	console.log("Successfully created user account with uid:", userData.uid);
    	var uid = userData.uid;
    	console.log(uid)
    	var data = {};
    	data[uid] = {
					email: email,
					phone: phone
					};

    	userRef.update(data); 
  	}
	});

	// display success message
	res.render('success');
});

app.listen(3000, function() {
	console.log("The frontend server is running on port 3000.");
});

// general error handling for user account creation
function printError(error) {
	switch (error.code) {
      	case "EMAIL_TAKEN":
        	console.log("The new user account cannot be created because the email is already in use.");
        	break;
      	case "INVALID_EMAIL":
        	console.log("The specified email is not a valid email.");
       	 	break;
      	default:
        	console.log("Error creating user:", error);
    	}
}