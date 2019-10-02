<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="signIn.css">

<meta charset="UTF-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="537846796151-19f0pb4cna2otih47e0sj850h29rosmg.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer
	type="text/javascript"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>HomeHub</title>	
</head>

<body>
	<img id=homehub src="https://i.imgur.com/qEIcvn6.png">
	<h1 id = "description">HomeHub is here to make weekly chores a breeze with your housemates. </h1>
	<img id = "happyHousemates" src = "https://imgur.com/g8hUFbQ.jpg">
	 
	<div class="g-signin2" style="outline: none;" data-onsuccess="onSignIn" onclick="myfunction"
		data-theme="dark" data-width="200" data-height="50"
		onClick="setBool()"></div>

	<button id="guest" type="button" onclick="location.href='Guest.jsp'">Continue
		as Guest</button>


	<script type="text/javascript">
		var SIGN_IN = false;
		var clickedButton = false;
		function setBool() {
			//console.log("button was clicked");
			clickedButton = true;
		}
		
		function myfunction()
		{
			
		}
		function onSignIn(googleUser) {
			//console.log("inside on sign in func");
			if (!SIGN_IN) {
				// Useful data for your client-side scripts:
				var profile = googleUser.getBasicProfile();
				console.log("ID: " + profile.getId()); // Don't send this directly to your server!
				console.log('Full Name: ' + profile.getName());
				console.log('Given Name: ' + profile.getGivenName());
				console.log('Family Name: ' + profile.getFamilyName());
				console.log("Image URL: " + profile.getImageUrl());
				console.log("Email: " + profile.getEmail());
				// Save data to sessionStorage
				sessionStorage.setItem('username', profile.getName());
				sessionStorage.setItem('pic', profile.getImageUrl());
				sessionStorage.setItem('email', profile.getEmail());
				//alert(sessionStorage.getItem('Full Name'));
				// The ID token you need to pass to your backend:
				var id_token = googleUser.getAuthResponse().id_token;
				//console.log("ID Token: " + id_token);
				SIGN_IN = true;
				//text to white
				//document.getElementById("ProfileSignIn").style.color = "white";
				//document.getElementById("HomeSignIn").style.color = "white";
				var email = profile.getEmail();
				
				$.ajax({
                    type: "GET",
                    url: "User",
                    data: {
                          email: email
                      },
                    success: function( data ) {
                    if(data =="false-null")
                        {
                            location.href='register.jsp';
                        }
                    else
                    {
                        var allData = data.split("-");
                        var house = allData[1];
                        sessionStorage.setItem('house', house);
                        location.href='schedule.jsp'
                    }
                    
                    
                    
                    },
                    error:function(data,status,er) {
                          alert("error: "+data+" status: "+status+" er:"+er);
                         }
                  });
				
			} else {
				//console.log("Signed out");
				signOut();
				SIGN_IN = false;
				//text to black
				document.getElementById("ProfileSignIn").style.color = "black";
				document.getElementById("HomeSignIn").style.color = "black";
			}
		};
		// Client ID and API key from the Developer Console
		var CLIENT_ID = '537846796151-19f0pb4cna2otih47e0sj850h29rosmg.apps.googleusercontent.com';
		var API_KEY = 'AIzaSyBweearV3vljt2NKqPDupv8Q7HIn6ET_ME';
		// Array of API discovery doc URLs for APIs used by the quickstart
		var DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest" ];
		// Authorization scopes required by the API; multiple scopes can be
		// included, separated by spaces.
		var SCOPES = "https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/calendar.readonly";
		var authorizeButton = document.getElementById('authorize_button');
		var signoutButton = document.getElementById('signout_button');
		/**
		 *  On load, called to load the auth2 library and API client library.
		 */
		function handleClientLoad() {
			gapi.load('client:auth2', initClient);
		}
		/**
		 *  Initializes the API client library and sets up sign-in state
		 *  listeners.
		 */
		function initClient() {
			gapi.client
					.init({
						apiKey : API_KEY,
						clientId : CLIENT_ID,
						discoveryDocs : DISCOVERY_DOCS,
						scope : SCOPES
					})
					.then(
							function() {
								// Listen for sign-in state changes.
								gapi.auth2.getAuthInstance().isSignedIn
										.listen(updateSigninStatus);
								// Handle the initial sign-in state.
								updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn
										.get());
								/*             g-signin2.onclick = handleAuthClick;
								 g-signin2.onclick = handleSignoutClick; */
							});
		}
		/**
		 *  Called when the signed in status changes, to update the UI
		 *  appropriately. After a sign-in, the API is called.
		 */
		function updateSigninStatus(isSignedIn) {
			console.log("clicked the button");
			if (isSignedIn) {
				let GoogleAuth = gapi.auth2.getAuthInstance();
				// Retrieve the GoogleUser object for the current user.
				var GoogleUser = GoogleAuth.currentUser.get();
				GoogleUser.grant({'scope':'https://www.googleapis.com/auth/calendar'})
				authorizeButton.style.display = 'none';
				signoutButton.style.display = 'block';
				listUpcomingEvents();
			} else {
				authorizeButton.style.display = 'block';
				signoutButton.style.display = 'none';
			}
		}
		/**
		 *  Sign in the user upon button click.
		 */
		function handleAuthClick(event) {
			/*         	console.log("clicked the button");
			 */SIGN_IN = false;
			clickedButton = true;
			console.log(clickedButton);
			gapi.auth2.getAuthInstance().signIn();
		}
		/**
		 *  Sign out the user upon button click.
		 */
		function handleSignoutClick(event) {
			gapi.auth2.getAuthInstance().signOut();
		}
		function signOut() {
			var auth2 = gapi.auth2.getAuthInstance();
			auth2.signOut().then(function() {
				console.log('User signed out.');
			});
		}
	</script>

</body>

</html>