// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function(){
  $("#bookmarks th a").live('click', function(){
    $.getScript(this.href);
    return false;
  });

  $("#bookmarks_search input").keyup(function() {
    $.get($("#bookmarks_search").attr("action"), $("#bookmarks_search").serialize(), null, "script");
    return false;
  });
});
