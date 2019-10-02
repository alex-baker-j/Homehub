<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.util.Vector" %>
    
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Roboto"
    rel="stylesheet">
    <script src="guest.js"></script>
    
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<link rel="stylesheet" href="guest_style.css">
</head>
<body>
    <% 
        Vector<Vector<String>> assigned = new Vector();
        assigned = (Vector<Vector<String>>)session.getAttribute("assigned_vector");
        System.out.println("In jsp");
        String vector_string = "";
        for(int i = 0; i < assigned.size(); i++){
            for(int j = 0; j < assigned.elementAt(i).size(); j++){
                
                System.out.println(i + 1);
                System.out.println(assigned.elementAt(i).elementAt(j));
                
                vector_string += assigned.elementAt(i).elementAt(j) + ",";
            }
            vector_string += ".";
        }
        
        System.out.println(vector_string);
    %>
    
        <img src="https://i.imgur.com/qEIcvn6.png" id="logo" onclick="redirect();">
        <script>
            function redirect() {
                window.location = "signIn.jsp";
            }
        </script>
        
        <br>
<div class="drag-container" >
<div class = "taskbox">
<div class = "taskboxheader">
<h1>User 1's Tasks</h1>
</div>
    <ul class="drag-list">
        <li class="drag-column drag-column-on-hold">
                <h2>Assigned</h2>
                
            <div class="drag-options" id="options1"></div>
            
            <ul class="drag-inner-list" id="01">
            </ul>
        </li>
        <li class="drag-column drag-column-in-progress">
                <h2>Completed</h2>
            <div class="drag-options" id="options2"></div>
            <ul class="drag-inner-list" id="02">
            </ul>
        </li>
    </ul>
    </div>
</div>
        <br>
<div class="drag-container" style="display: none;" id = "g1">
<div class = "taskbox">
<div class = "taskboxheader">
<h1>User 2's Tasks</h1>
</div>
    <ul class="drag-list">
        <li class="drag-column drag-column-on-hold">
                <h2>Assigned</h2>
            <div class="drag-options" id="options1"></div>
            <ul class="drag-inner-list" id="11">
            </ul>
        </li>
        <li class="drag-column drag-column-in-progress">
                <h2>Completed</h2>
            <div class="drag-options" id="options2"></div>
            <ul class="drag-inner-list" id="12">
            </ul>
        </li>
    </ul>
    </div>
</div>
        <br>
<div class="drag-container" style="display: none;" id = "g2">
<div class = "taskbox">
<div class = "taskboxheader">
<h1>User 3's Tasks</h1>
</div>
    <ul class="drag-list">
        <li class="drag-column drag-column-on-hold">
                <h2>Assigned</h2>
            <div class="drag-options" id="options1"></div>
            <ul class="drag-inner-list" id="21">
            </ul>
        </li>
        <li class="drag-column drag-column-in-progress">
                <h2>Completed</h2>
            <div class="drag-options" id="options2"></div>
            <ul class="drag-inner-list" id="22">
            </ul>
        </li>
    </ul>
    </div>
</div>
        <br>
<div class="drag-container" style="display: none;" id = "g3">
<div class = "taskbox">
<div class = "taskboxheader">
<h1>User 4's Tasks</h1>
</div>
    <ul class="drag-list">
        <li class="drag-column drag-column-on-hold">
                <h2>Assigned</h2>
            <div class="drag-options" id="options1"></div>
            <ul class="drag-inner-list" id="31">
            </ul>
        </li>
        <li class="drag-column drag-column-in-progress">
                <h2>Completed</h2>
            <div class="drag-options" id="options2"></div>
            <ul class="drag-inner-list" id="32">
            </ul>
        </li>
    </ul>
    </div>
</div>
        <br>
<div class="drag-container" style="display: none;" id = "g4">
<div class = "taskbox">
<div class = "taskboxheader">
<h1>User 5's Tasks</h1>
</div>
    <ul class="drag-list">
        <li class="drag-column drag-column-on-hold">
                <h2>Assigned</h2>
            <div class="drag-options" id="options1"></div>
            <ul class="drag-inner-list" id="41">
            </ul>
        </li>
        <li class="drag-column drag-column-in-progress">
                <h2>Completed</h2>
            <div class="drag-options" id="options2"></div>
            <ul class="drag-inner-list" id="42">
            </ul>
        </li>
    </ul>
    </div>
</div>
        <br>
<div class="drag-container" style="display: none;">
<div class = "taskbox">
<div class = "taskboxheader">
<h1>User 6's Tasks</h1>
</div>
    <ul class="drag-list">
        <li class="drag-column drag-column-on-hold">
                <h2>Assigned</h2>
            <div class="drag-options" id="options1"></div>
            <ul class="drag-inner-list" id="1">
            </ul>
        </li>
        <li class="drag-column drag-column-in-progress">
                <h2>Completed</h2>
            <div class="drag-options" id="options2"></div>
            <ul class="drag-inner-list" id="2">
            </ul>
        </li>
    </ul>
    </div>
</div>
<script>
    var user_tasks_string = "<%=vector_string%>";
    var user_tasks_array = user_tasks_string.split('.');
    for(i = 0; i < user_tasks_array.length-1; i++)
        {
        var Assigned = document.getElementById(i+'1');
        if(i > 0)
        document.getElementById('g'+i).style ="display: block; margin-left: auto; margin-right: auto;";
        var tasks = user_tasks_array[i].split(',');
        for(j = 0; j < tasks.length - 1; j++){
            var taskboxitem = document.createElement("li");
            taskboxitem.className = "drag-item";
            taskboxitem.innerHTML = tasks[j];
            Assigned.appendChild(taskboxitem);
        }
        }
        </script> 
    
    
        <script
        src='https://s3-us-west-2.amazonaws.com/s.cdpn.io/45226/dragula.min.js'>
</script>
   <script src = "guest.js"></script> 
</body>
</html>