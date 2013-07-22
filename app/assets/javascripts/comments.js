$(document).ready(function(){

	$(document).on("click", ".click-link",function() {
			 $(this).closest('.activities_partial').find('.comment-form').toggle(".comment-form");
	});

	$(document).on("ajax:success", "#create-comment-form",function(evt,data,status,xhr) {
			$(this).closest('.whole-comment').replaceWith(xhr.responseText);
	});

	$(document).on("ajax:error", "#create-comment-form",function(evt,xhr,status,error) {
		$(this).closest('.comment-form').replaceWith(xhr.responseText);
		// $(this).closest('.comment-form').css("display","inline");
		// $('#create-comment-form').css("display","inline");
	});
});