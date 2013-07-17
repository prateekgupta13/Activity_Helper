$(document).ready(function(){

	$(document).on("ajax:success", "#create_activity_form",function(evt,data,status,xhr) {
		$('.activities').find('.activities_partial').replaceWith(xhr.responseText);
	});
	
	$(document).on("ajax:error", "#create_activity_form",function(evt,xhr,status,error) {
		 $('.abc').find('.act').replaceWith(xhr.responseText);
	});
});