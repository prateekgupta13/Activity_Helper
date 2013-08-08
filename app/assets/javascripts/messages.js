$(document).ready(function(){

	$(document).on("click", "#seemsg",function() {
	    $(".messages-partial").toggle('slow', function() {
			$('.animation-complete').toggle();
		});
	});	

	$(document).on("ajax:success", "#msg-create",function(evt,data,status,xhr) {
		$('.mutual-msg').replaceWith(xhr.responseText);

		 var el=$('#msg-create');
		 el.find('input:text,textarea').val('');		  
	});

	$(document).on("click",".see-conversation",function() {
	    $(this).closest('.friends').find('.unread').html("U0");
	   	// $(this).closest('.friends').css("background-color","#BD32B2");     
	});

	$(document).on("ajax:success", "#index-msgform",function(evt,data,status,xhr) {

		 var el=$('#index-msgform');
		 el.find('input:text,textarea').val('');		  
	});

	// $('.ad').keyup(function(){

	$('.ad').text('@').typeahead({                                
  		name: 'friends',
    	remote: '/messages/get_friends?q=%QUERY',
    	header: '<h4><center>Friends</center></h4>',
    	template: '<img class="img-typeahead" src={{img}}/> {{text}}',
    	// template: '<i class="icon-user icon-red"></i>&nbsp;{{value}}',
    	

    	engine: Hogan,
    	limit: 5
  		
	// });
	});

	$(document).on("click",".see-conversation",function() {
		
		setTimeout(updateMessages, 10000);
	});

	function updateMessages () {
  		var recipient_id = $(".mutual-msg").attr("data-id");
		var after = $(".mutual-msg:last-child").attr("data-time");
		
		$.getScript("/messages.js?recipient_id=" + recipient_id + "&after=" + after);
		setTimeout(updateMessages, 10000);
	}

});
	 