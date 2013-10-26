jQuery(function($) {
	$('.menu').each( function(i, el){
	    $(el).css({'opacity':0});
	    setTimeout(function(){
    		$(el).animate({
        		'opacity':1.0
       			}, 50);
    	},100 + ( i * 100 ));
	});
});