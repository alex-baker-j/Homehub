<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="mypackage.UserObj" import="java.io.IOException"
    import="java.sql.Connection" import="java.sql.DriverManager"
    import="java.sql.PreparedStatement" import="java.sql.ResultSet"
    import="java.sql.SQLException" import="java.sql.Statement"
    import="java.util.ArrayList" import="java.util.Arrays"
    import="java.util.List" import="java.util.Vector"
    import="java.sql.Driver" import="java.util.LinkedList"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Roboto"
    rel="stylesheet">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="style.css">
<script src="index.js"></script>
<title>HomeHub</title>
</head>
<body onload="start();">
    <div class="container">
        <div class="calendar light">
            <div class="calendar_header">
                <h1 class="header_title">Notifications</h1>
                <p class="header_copy">Updates</p>
            </div>
            <div class="calendar_plan">
                <div class="cl_plan">
                    <div class="cl_title">Today's Date</div>
                    <div id="date" class="cl_copy"></div>
                    <!--     <div class="cl_add">
          <p class="number">1</p>
        </div>  -->
                </div>
            </div>
            <div class="calendar_events">
                <p class="ce_title">Latest Notifications</p>
            </div>
        </div>
    </div>
    <div class="header">
        <img id="logo" src="https://imgur.com/PqqVa2l.png" border="0"
            onclick="signOut();" />
    </div>
    <section class="section">
        <h1>
            <img id="profilePic" style='border-radius: 50%;'><br>My
            Tasks
        </h1>
        <button id="nextWeek" onclick="nextWeek();">Advance A Week</button>
        <script>
            function nextWeek() {
                var xhttp = new XMLHttpRequest();
                xhttp.open("GET", "Distribute", false);
                var houseName = sessionStorage.getItem('houseName');
                xhttp.setRequestHeader("name", houseName);
                xhttp.send();
            }
        </script>
    </section>
    <div class="drag-container">
        <ul class="drag-list">
            <li class="drag-column drag-column-next-week"><span
                class="drag-column-header">
                    <h2>Next Week</h2>
            </span>
                <div class="drag-options" id="options1"></div>
                <ul class="drag-inner-list" id="1">
                </ul></li>
            <li class="drag-column drag-column-this-week"><span
                class="drag-column-header">
                    <h2>This Week</h2>
            </span>
                <div class="drag-options" id="options2"></div>
                <ul class="drag-inner-list" id="2">
                </ul></li>
            <li class="drag-column drag-column-completed"><span
                class="drag-column-header">
                    <h2>Completed</h2>
            </span>
                <div class="drag-options" id="options3"></div>
                <ul class="drag-inner-list" id="3">
                </ul></li>
        </ul>
    </div>
    <div class="householdtasks" id="householdtasks"></div>
    <script>
        document.getElementById('profilePic').src = sessionStorage
                .getItem('pic');
        var socket;
        function start() {
            todaysDate();
            socketCreation();
        }
        function todaysDate() {
            var today = new Date();
            var months = [ 'January', 'February', 'March', 'April', 'May',
                    'June', 'July', 'August', 'September', 'October',
                    'November', 'December' ];
            var date = today.getDate() + " " + months[today.getMonth()] + " "
                    + today.getFullYear();
            document.getElementById("date").innerHTML = date;
        }
        function socketCreation() {
            console.log("success running")
            socket = new WebSocket("ws://localhost:8080/HomeHub/Server");
            socket.onopen = function(event) {
                //Multithreading register
                var name = sessionStorage.getItem('username');
                var house = sessionStorage.getItem('house');
                var message = name + "," + house + ",register,blank";
                socket.send(message);
            }
            socket.onmessage = function(event) {
                console.log("success onmessage")
                var message = event.data
                var cal = document.getElementsByClassName('calendar_events')[0];
                var html = "<div class='event_item'><div class='ei_Dot dot_active'></div><div class='ei_Title'>10:30 am</div><div class='ei_Copy'>Monday briefing with the team</div></div>"
                cal.innerHTML += html;
                //Update Frontend when message is received. message is the text we want to display
            }
            /* socket.onclose = function(event){
                
            } */
        }
        dragula(
                [ document.getElementById('2'), document.getElementById('3'),
                        document.getElementById('4'),
                        document.getElementById('5') ]).on('drag',
                function(el) {
                    // add 'is-moving' class to element being dragged
                    el.classList.add('is-moving');
                }).on(
                'dragend',
                function(el) {
                    console.log(el);
                    var email = sessionStorage.getItem('email');
                    // remove 'is-moving' class from element after dragging has stopped
                    el.classList.remove('is-moving');
                    var task = el.innerHTML.trim();
                    console.log(task);
                    $.ajax({
                        type : "GET",
                        url : "DragDrop",
                        data : {
                            task : task,
                            email : email
                        },
                        success : function(data) {
                            console.log("data: " + data);
                            var name = sessionStorage.getItem('username');
                            var house = sessionStorage.getItem('house');
                            var status = data;
                            var message = name + "," + house + ",update,"
                                    + task + "-" + status;
                            socket.send(message);
                        }
                    });
                    // add the 'is-moved' class for 600ms then remove it
                    window.setTimeout(function() {
                        el.classList.add('is-moved');
                        window.setTimeout(function() {
                            el.classList.remove('is-moved');
                        }, 600);
                    }, 100);
                });
    </script>
    <script>
        function success() {
            console.log("help");
            var email = sessionStorage.getItem("email");
            console.log(email);
            $.ajax({
                type : "POST",
                url : "PopulateSchedule",
                data : {
                    email : email
                },
                //async: false,
                success : function(data) {
                    console.log("data: " + data);
                    pop(data);
                },
                error : function(data) {
                    console.log("error" + data);
                }
            });
        }
        success();
        function pop(data) {
            console.log("DATA: " + data);
            var user = data.split('*');
            console.log(user);
            var NextWeekList = document.getElementById('1');
            var ThisWeekList = document.getElementById('2');
            var CompletedList = document.getElementById('3');
            var Household = document.getElementById('householdtasks');
            var thisuser = user[0].split('/');
            var thistasks = parse(thisuser[2]);
            for (var i = 0; i < thistasks.length; i++) {
                if (thistasks[i].trim().length == 0)
                    break;
                var new_li = document.createElement('li');
                new_li.className = "drag-item";
                if (thistasks[i] != "") {
                    new_li.innerHTML = thistasks[i];
                    NextWeekList.appendChild(new_li);
                }
            }
            var next = parse(thisuser[3]);
            for (var i = 0; i < thistasks.length; i++) {
                if (next[i].trim().length == 0)
                    break;
                var new_li = document.createElement('li');
                new_li.className = "drag-item";
                if (next[i]) {
                    new_li.innerHTML = next[i];
                    ThisWeekList.appendChild(new_li);
                }
            }
            var done = parse(thisuser[4]);
            for (var i = 0; i < thistasks.length; i++) {
                if (done[i].trim().length == 0)
                    break;
                console.log("done");
                var new_li = document.createElement('li');
                new_li.className = "drag-item";
                if (done[i]) {
                    new_li.innerHTML = done[i];
                    CompletedList.appendChild(new_li);
                }
            }
            for (var i = 1; i < user.length - 1; i++) {
                (function() {
                    var u = user[i].split('/');
                    console.log(u);
                    var t = parse(u[3]);
                    var c = parse(u[4]);
                    console.log(t + c);
                    var outer = document.createElement('div');
                    outer.className = "outer";
                    Household.appendChild(outer);
                    var Taskbox = document.createElement('div');
                    Taskbox.className = "taskbox";
                    outer.appendChild(Taskbox);
                    var Taskboxheader = document.createElement('div');
                    Taskboxheader.className = "taskboxheader";
                    Taskboxheader.innerHTML = u[0] + "\'s Tasks";
                    Taskbox.appendChild(Taskboxheader);
                    var Assigned = document.createElement('div');
                    Assigned.className = "assigned";
                    Assigned.innerHTML = "<h4>To-do</h4>";
                    Taskbox.appendChild(Assigned);
                    var TaskboxList1 = document.createElement('li');
                    TaskboxList1.className = "taskboxlist";
                    Assigned.appendChild(TaskboxList1);
                    var Completed = document.createElement('div');
                    Completed.className = "completed";
                    Completed.innerHTML = "<h4>Completed</h4>";
                    Taskbox.appendChild(Completed);
                    var TaskboxList2 = document.createElement('li');
                    TaskboxList2.className = "taskboxlist";
                    Completed.appendChild(TaskboxList2);
                    console.log(t.length);
                    for (var j = 0; j < t.length; j++) {
                        if (t[j].trim().length == 0)
                            break;
                        console.log("todo");
                        var TaskboxListItem = document.createElement('ul');
                        TaskboxListItem.className = "taskboxitem";
                        TaskboxListItem.innerHTML = t[j];
                        TaskboxList1.appendChild(TaskboxListItem);
                    }
                    for (var j = 0; j < c.length; j++) {
                        if (c[j].trim().length == 0)
                            break;
                        var TaskboxListItem = document.createElement('ul');
                        TaskboxListItem.className = "taskboxitem";
                        TaskboxListItem.innerHTML = c[j];
                        TaskboxList2.appendChild(TaskboxListItem);
                    }
                    var Break = document.createElement('br');
                    Household.appendChild(Break.cloneNode());
                    var btn = document.createElement("BUTTON"); // Create a <button> element
                    var t = document.createTextNode("POKE"); // Create a text node
                    btn.className = "btn";
                    btn.appendChild(t); // Append the text to <button>
                    outer.appendChild(btn); // Append <button> to <body>
                    var data_ = u[0];
                    console.log("dat" + data_);
                    btn.addEventListener("click", function() {
                        poke(data_);
                    }, false);
                    outer.appendChild(btn); // Append <button> to <body>
                }());
            }
        }
        function poke(name) {
            console.log(name);
            var poker = sessionStorage.getItem('username');
            var poked = name;
            var house = sessionStorage.getItem('house');
            console.log("House: " + house);
            var message = poker + "," + house + ",poke," + poker + "-" + poked;
            socket.send(message);
            console.log(name);
        }
        function parse(obj) {
            obj = obj.replace(']', '');
            obj = obj.replace('[', '');
            return obj.split(',');
        }
    </script>
    <script>
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
                apiKey : API_KEY,
                clientId : CLIENT_ID,
                discoveryDocs : DISCOVERY_DOCS,
                scope : SCOPES
            }).then(
                    function() {
                        // Listen for sign-in state changes.
                        gapi.auth2.getAuthInstance().isSignedIn
                                .listen(updateSigninStatus);
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
            console.log("in here!");
            var auth2 = gapi.auth2.getAuthInstance();
            auth2.signOut().then(function() {
                window.location = "signIn.jsp"
            });
        }
    </script>
    <script async defer src="https://apis.google.com/js/api.js"
        onload="this.onload=function(){};handleClientLoad()"
        onreadystatechange="if (this.readyState === 'complete') this.onload()">
        
    </script>
    <script
        src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/45226/dragula.min.js'></script>
    <script src="index.js"></script>
</body>
</html>