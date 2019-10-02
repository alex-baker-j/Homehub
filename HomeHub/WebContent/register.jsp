<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>HomeHub</title>
<link href="register.css" rel="stylesheet" type="text/css">

</head>
<script>
// handles toggling when user chooses to create a household or join existing household
function householdclickB() {
	document.getElementById("household").style.display = "block";
	document.getElementById("create").style.display = "block";
}
function householdclickA() {
	document.getElementById("household").style.display = "block";
	document.getElementById("create").style.display = "none";
}
</script>
<body>
		<img id="homehublogo" src="https://i.imgur.com/qEIcvn6.png" border="0" onclick="signOut();"/>
	<br />
	<div id="register">
		<span class = "header">
		<h3>Welcome to HomeHub</h3>
		</span>	
	<div id = "internal">
		
		<input type="radio" name="household" value="Create" id="radio-one" class="form-radio" onclick="householdclickB()" /> Create household 
			<input type="radio" name="household" value="Join"id="radio-one" class="form-radio"  onclick="householdclickA()" /> Join household 
			<br /> 
            <div id = "household" style="display:none">
            
                <fieldset>
      			<br /> 
      
      <input class="form__input"  id = "houseName" type="text" placeholder="Enter Household Name" required />
    </fieldset>
    
    			</div>
			<div id="create"  style="display:none">
						<br>
			
				<h2>Check tasks for your Household </h2><br />
				<div id = "tasks">
				    <input type="checkbox" class="form-checkbox" id="check-one" ><label for="check-one">Checkbox</label>
				        <input type="checkbox" class="form-checkbox" id="check-one" checked><label for="check-one">Checkbox2</label>
				   </div>
				
<!-- 				<h2>What day should these tasks be completed by? </h2>
				<select id = "header-container">
					<option value="Monday">Monday</option>
					<option value="Tuesday">Tuesday</option>
					<option value="Wednesday">Wednesday</option>
					<option value="Thursday">Thursday</option>
					<option value="Friday">Friday</option>
					<option value="Saturday">Friday</option>
					<option value="Sunday">Friday</option>
				</select> -->
				</div> 
			</div>
			<br>
			<input id="submit" type="submit" name="submit" value="Submit" class = 'form__submit' onclick="createHousehold();"/>
	</div>
		</div>
		
		<script>
		
		// prints list of tasks user can select from based on available tasks in database to screen
		var xhttp = new XMLHttpRequest();
		xhttp.open("GET", "Tasks", false);
		xhttp.send();
		var tasks = xhttp.getResponseHeader("tasks");
		var tasksList = tasks.split(",");
		var html = "";
		for (var i = 0; i < tasksList.length; i++) {
			html += '<input type="checkbox" name="task" class="form-checkbox" id="check-one" ><label for="check-one">' + tasksList[i] + "</label>";
			if ((i%2)!=0) 
				html += '<br>';
		}
		html+= '<label>Custom Tasks</label><input type="textarea" name="task" class="form-checkbox" id="custom" style="width: 200px;margin-left: 10px;" placeholder="Separate w/ commas..."><label for="check-one">'
		document.getElementById('tasks').innerHTML = html;
		
		// Client ID and API key from the Developer Console
        var CLIENT_ID = '537846796151-19f0pb4cna2otih47e0sj850h29rosmg.apps.googleusercontent.com';
        var API_KEY = 'AIzaSyBweearV3vljt2NKqPDupv8Q7HIn6ET_ME';
        // Array of API discovery doc URLs for APIs used by the quickstart
        var DISCOVERY_DOCS = [ "https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest" ];
		
	     // Authorization scopes required by the API; multiple scopes can be
	      // included, separated by spaces.
	      var SCOPES = "https://www.googleapis.com/auth/calendar.readonly";
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
	        gapi.client.init({
	          apiKey: API_KEY,
	          clientId: CLIENT_ID,
	          discoveryDocs: DISCOVERY_DOCS,
	          scope: SCOPES
	        }).then(function () {
	          // Listen for sign-in state changes.
	          gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);
	          // Handle the initial sign-in state.
	          //updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
	          //authorizeButton.onclick = handleAuthClick;
	          //signoutButton.onclick = handleSignoutClick;
	        });
	      }
	      /**
	       *  Called when the signed in status changes, to update the UI
	       *  appropriately. After a sign-in, the API is called.
	       */
	      function updateSigninStatus(isSignedIn) {
	        if (isSignedIn) {
	          /* authorizeButton.style.display = 'none';
	          signoutButton.style.display = 'block'; */
	          createUser();
	        } else {
	          /* authorizeButton.style.display = 'block';
	          signoutButton.style.display = 'none'; */
	        }
	      }
	      /**
	       *  Sign in the user upon button click.
	       */
	      function handleAuthClick(event) {
	        gapi.auth2.getAuthInstance().signIn();
	      }
	      /**
	       *  Sign out the user upon button click.
	       */
	       function signOut() {
	    	  var auth2 = gapi.auth2.getAuthInstance();
	           auth2.signOut().then(function () {
	             window.location = "signIn.jsp"
	       	   });
	      }
	</script>
	
	    <script async defer src="https://apis.google.com/js/api.js"
      onload="this.onload=function(){};handleClientLoad()"
      onreadystatechange="if (this.readyState === 'complete') this.onload()">
    </script>
	<script>
		// BOTH creates a household and adds the user creating the household into the database
		function createHousehold() {
			// extract information from session storage and html inputs
			var email = sessionStorage.getItem("email");
			var username = sessionStorage.getItem("username");
			var pic = sessionStorage.getItem("pic");
			var houseName = document.getElementById("houseName").value;
			if (houseName == "") {
				alert("Must provide house name");
				return;
			}
			sessionStorage.setItem("houseName", houseName);
			houseName = houseName.replace(" ", "_");
			var xhttp = new XMLHttpRequest();
			// add user to database
			// query database for all existing households to check if household exists
			// create household...
				// 2 -> add household if not already present
				// 		(need to send the number of existing households for foreign key generation)
			// add user to household...
				// 1 -> add user email to respective household table
			xhttp.open("GET", "Register", false);
			xhttp.send();
			var householdsString = xhttp.getResponseHeader("households");
			var householdsList = householdsString.split(",");
			var create = document.getElementsByName("household")[0].checked;
			var join = document.getElementsByName("household")[1].checked;
			if (create) {
				if (!householdsList.includes(houseName)) {
					// create user
					xhttp.open("POST", "User", false);
					xhttp.setRequestHeader("email", email);
					xhttp.setRequestHeader("fullName", username);
					xhttp.setRequestHeader("profilePic", pic);
					xhttp.setRequestHeader("houseName", houseName);
					xhttp.send();
					
					xhttp.open("POST", "Register", false);
					xhttp.setRequestHeader("name", houseName);
					var len = 0;
					if (householdsList[0] != "") {
						len = householdsList.length;
					}
					console.log(householdsList);
					if (!householdsList.includes(houseName)) {
						xhttp.setRequestHeader("type", "create");
						xhttp.setRequestHeader("len", len);
					}
					xhttp.send();
					// also need to join the household you've created
					xhttp.open("POST", "Register", false);
					xhttp.setRequestHeader("type", "join");
					xhttp.setRequestHeader("email", email);
					xhttp.setRequestHeader("name", houseName);
					xhttp.send();
					console.log(email);
					var tasks = document.getElementsByName("task");
					var tasksString = ""
					for (let i = 0; i < tasks.length; i++) {
						if (tasks[i].checked) {
							tasksString += tasksList[i] + ",";
						}
					}
					var temp = document.getElementById('custom').value;
					var customTasks = temp.split(',');
					for (let i = 0; i < customTasks.length; i++) {
						if (customTasks[i]) {
							tasksString += customTasks[i].trim() + ",";
						}
					}
					console.log("tasks")
					xhttp.open("POST", "Tasks", false);
					xhttp.setRequestHeader("tasks", tasksString);
					xhttp.setRequestHeader("household", houseName);
					xhttp.send();
				} else {
					alert("Household already exist!");
					return;
				}
			} else if (join) {				
				if (householdsList.includes(houseName)) {
					// create user
					xhttp.open("POST", "User", false);
					xhttp.setRequestHeader("email", email);
					xhttp.setRequestHeader("fullName", username);
					xhttp.setRequestHeader("profilePic", pic);
					xhttp.setRequestHeader("houseName", houseName);
					xhttp.send();
					// register them in household
					xhttp.open("POST", "Register", false);
					xhttp.setRequestHeader("name", houseName);
					xhttp.setRequestHeader("type", "join");
					xhttp.setRequestHeader("email", email);
					xhttp.send();
				} else {
					alert("Household doesn't exist!");
					return;
				}
			}
			// distribute tasks
			xhttp.open("POST", "Distribute", false);
			xhttp.setRequestHeader("name", houseName);
			xhttp.send();
			console.log("updated1!");
			location.href = 'schedule.jsp';
		}
	</script>
</body>
</html>