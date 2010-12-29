/* DO NOT MODIFY. This file was compiled Wed, 29 Dec 2010 15:50:40 GMT from
 * /Users/mech/Works/Source/interviewer_app/app/coffeescripts/app.coffee
 */

(function() {
  $(function() {
    var sub_hide, sub_show;
    $("input[type=text]:not(.search):first").focus();
    sub_show = function() {
      return $(this).find("ul.sub").show();
    };
    sub_hide = function() {
      return $(this).find("ul.sub").hide();
    };
    $("nav li").hover(sub_show, sub_hide);
    $(".sortable").sortable({
      axis: 'y',
      items: 'li',
      handle: '.points',
      opacity: 0.6,
      scroll: true,
      update: function() {
        return alert("re-ordering...");
      }
    });
    $("ul#questions form").bind("ajax:beforeSend", function() {
      $("ul#questions").animate({
        opacity: 0.3
      });
      return $("ul#questions .loading").show();
    });
    return $("ul#questions form").bind("ajax:complete", function() {
      $("ul#questions").animate({
        opacity: 1.0
      });
      return $("ul#questions .loading").hide();
    });
  });
}).call(this);
