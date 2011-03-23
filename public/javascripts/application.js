$(function(){
  $("#bookmarks th a").live('click', function(){
    $.getJSON(this.href, function(bookmarks){
      $("#bookmarkListTemplate").tmpl(bookmarks).appendTo($("#bookmark-template").empty());
    });
    return false;
  });

  $("#bookmarks_search input").keyup(function() {
    $.get($("#bookmarks_search").attr("action"), $("#bookmarks_search").serialize(), null, "script");
    return false;
  });
});
