$(document).ready(function(){

	$(document).on("ajax:success", "#create_activity_form",function(evt,data,status,xhr) {
		 $('.activities').find('#new').prepend(xhr.responseText);

		 var el=$('#create_activity_form');
		 el.find('input:text,textarea').val('');
		 el.find('select option').prop('selected',false);
		  
	});
	
	$(document).on("ajax:error", "#create_activity_form",function(evt,xhr,status,error) {
		 $('.abc').find('.act').replaceWith(xhr.responseText);
	});

}); 