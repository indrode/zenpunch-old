// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// jQuery commenting

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {
	$("#new_comment").validate();
	$("#new_comment").submitWithAjax();	
})


function toggleDiv(divname) {
	$("#"+divname).slideToggle("slow");
}


$(document).ready(function() {
	
	// Expand Panel
	$("#open").click(function(){
		$("div#panel").slideDown("slow");
	
	});	
	
	// Collapse Panel
	$("#close").click(function(){
		$("div#panel").slideUp("slow");	
	});		
	
	// Switch button labels on click
	$("#toggle a").click(function () {
		$("#toggle a").toggle();
	});		
		
});
