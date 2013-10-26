$(document).ready(function(){
	$(".avatarPerFoto").load(function() {
		$(this).wrap(function(){
			return '<span class="' + $(this).attr('class') + '" style="background:url(' + $(this).attr('src') + ') no-repeat center center; width: ' + $(this).width() + 'px; height: ' + $(this).height() + 'px;" />';
		});
		$(this).css("opacity","0");
	});
});