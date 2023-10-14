$(document).ready(function($) {
	$(".scroll_move").click(function(event) {
		console.log(".scroll_move");
		event.preventDefault();
		$('html,body').animate({ scrollTop: $(this.hash).offset().top }, 500);
	});

});