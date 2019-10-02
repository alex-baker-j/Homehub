dragula([
	document.getElementById('02'),
	document.getElementById('01'),
	document.getElementById('12'),
	document.getElementById('11'),
	document.getElementById('22'),
	document.getElementById('21'),
	document.getElementById('32'),
	document.getElementById('31'),
	document.getElementById('42'),
	document.getElementById('41')

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
	var task = el.innerHTML;
	console.log(task);
   
	// add the 'is-moved' class for 600ms then remove it
	window.setTimeout(function() {
		el.classList.add('is-moved');
		window.setTimeout(function() {
			el.classList.remove('is-moved');
		}, 600);
	}, 100);
});