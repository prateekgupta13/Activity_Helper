$(document).ready(function(){

	$(document).on("click", ".click-link",function() {
			 $(this).closest('.activities_partial').find('.comment-form').toggle(".comment-form");
	});

	$(document).on("ajax:success", "#create-comment-form",function(evt,data,status,xhr) {
			$(this).closest('.whole-comment').replaceWith(xhr.responseText);
	});
});