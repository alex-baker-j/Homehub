var socket;
function socketCreation() {
	console.log("success running")
	socket = new WebSocket("ws://localhost:8080/HomeHub/Server");
    socket.onopen = function(event){
        //Multithreading register
        var name = sessionStorage.getItem('username');
        var house = sessionStorage.getItem('house');
        var message = name + "," + house + ",register,blank";
        socket.send(message);
    	
    }
    socket.onmessage = function(event){
    	console.log("success onmessage")
        var message = event.data
        var cal = document.getElementsByClassName('calendar_events')[0];
    	var html = "<div class='event_item'><div class='ei_Dot dot_active'></div><div class='ei_Title'>Task Update</div><div class='ei_Copy'>" + message + "</div></div>"
        cal.innerHTML += html;
    	//Update Frontend when message is received. message is the text we want to display
    }
    socket.onclose = function(event){
        
    }
}

dragula([
	document.getElementById('2'),
	document.getElementById('3'),
	document.getElementById('4'),
	document.getElementById('5')
])

.on('drag', function(el) {
	
	// add 'is-moving' class to element being dragged
	el.classList.add('is-moving');
})
.on('dragend', function(el) {
	console.log(el);
	var email = sessionStorage.getItem('email');
	// remove 'is-moving' class from element after dragging has stopped
	el.classList.remove('is-moving');
	var task = el.innerHTML.trim();
	console.log(task);
    $.ajax({
  	  type: "GET",
  	  url: "DragDrop",
  	  data: {
  		  		task: task,
  		  		email: email
			},
    	success: function(data) {
    		console.log("data: " + data);
    		var name = sessionStorage.getItem('username');
    		var house = sessionStorage.getItem('house');
    		var status = data;
    		var message = name + "," + house + ",update," + task + "-" + status;
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
