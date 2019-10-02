<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="Guest.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
</head>
<title>HomeHub</title>

<body>
	<a href="signIn.jsp"> <img src="https://i.imgur.com/qEIcvn6.png"
		id="homehub">
	</a>
	<div id="box">
		<span class = "header">
		<h3 id="guest">As a guest, you can pick tasks and see how they
			would be distributed in a household.</h3>
		</span>
		<br> <font id="users"> Number of users you want to assign
			this task to? </font> <br>

		<div id="tasks">
			<form id = "guestForm" action="Distribution_Guest" method="POST"  onsubmit="return isEmpty();">
				<div class="select" id="usersSelectNumber">
					<br> <select id="numbers" name="numberOfUsers">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
					</select>
					<div class="select__arrow"></div>
				</div>
				<br> <font id="users">What tasks should your household
					have?</font> <br>
				<div id="checks">
					<input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Groceries"> <label>Buy Groceries</label><br>
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Vacuum"> <label>Vacuum</label> <br>
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Take_Out_Trash"> <label>Take Out Trash</label><br>
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Wash_Dishes"> <label>Wash Dishes</label><br>    
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Water_Plants"> <label>Water Plants</label><br>
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Dust_Cabinets"> <label>Dust Cabinets</label> <br>
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Wash_Communal_Towels"> <label>Wash Communal Towels</label><br>
              <input type="checkbox" name="tasks" class="form-checkbox" id="check-one" value="Clean_Garage"> <label>Clean Garage</label><br>
              </div>
              <input id = "submit" type="submit" value="Submit">
              
        </form> 
        <br>
        
        </div> 
    </div>
    
    <script>
    	function isEmpty(){
    		if($('.form-checkbox:checked').length == 0){
    			alert("You must check at least one task.");
    			//$("#guestForm").submit(function(){
    			//	return false;
    			//});
    			console.log("returning false");
				return false;
    		}
    		console.log("returning true");
			return true;

    	}
	    
    
    	
    </script>
</body>
</html>