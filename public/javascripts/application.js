$(function() {
  $("#gsub_pattern_input, #gsub_replacement_input, #test_string").bind('keyup', function(e){
    $.post('/', $(e.target).parents("form").serialize(), function(response){
      var results = eval("(" + response + ")");
      var result;
      $("#gsub_answer").empty();
      $("#gsub_error").empty();
      if(results.gsub_string){
        result = escapeHTMLEncode(results.gsub_string[0])
        if(result == "undefined")
          result = "no matches"
        if(result == "null")
          result = "[EMPTY STRING]"
        $("#gsub_answer").css('color', 'green');
        $("#gsub_answer").html(result);
      }
      else
        $("#gsub_answer").css('color', 'red');
        $("#gsub_answer").html(results.error);
    });
  })
})

function escapeHTMLEncode(str) {
 var div = document.createElement('div');
 var text = document.createTextNode(str);
 div.appendChild(text);
 return div.innerHTML;
}

// Hacky way of stopping enter from submitting...
$(document).ready(function() {
  $(window).keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
});