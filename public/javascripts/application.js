$(document).ready(function() {
  $("input[name=search_box]").keyup(function(event){
    var text = $(this).attr("value");
    var div = $("div.searchResult");
    if(event.keyCode == 40 && div.length > 0) {
      div.find("a:first").hover();
      return;
    }
    if(text.length >= 3)
      $("#search_form").submit();
    else
      $("div.searchResult").fadeOut();
      
  });
  
  $("#search_form")
  .bind("ajax:before", function(evt, xhr, settings) {
    var text = $(this).find("input[name=search_box]").attr("value");
    if(text.length < 3) {
      return false;
    }
    $(this).find("div.searchResult").remove();
  })
  .bind("ajax:success", function(evt, data, status, xhr) {
    var response = $.parseJSON(xhr.responseText);
    var responseLength = response.length;
    if(responseLength == 0) return;
    
    var searchResult = $("<div>");
    searchResult.addClass("searchResult");
    
    for(var i = 0; i < responseLength; i++) {
      var item = $("<div>");
      item.append("<span>" + response[i].note.title + "</span>");
      item.append("<p><a href=\"/notes/" + response[i].note.id +"\">" + response[i].note.description + "</a></p>");
      searchResult.append(item);
    }
    
    $(this).append(searchResult);
    searchResult.fadeIn('fast');
    var isHover = false;
    searchResult.hover(function(){
      isHover = true;
    }, function() {
      isHover = false;  
    });
    
    $(this).find("input[name=search_box]").blur(function() {
      if(searchResult.find("a:focus").length > 0) return;
      if(!isHover)
        searchResult.fadeOut();
    });
    
  });
  
  $("p.notice img").click(function() {
    $(this).parent().fadeOut();
  });
});
