/* DO NOT MODIFY. This file was compiled Tue, 28 Dec 2010 12:51:31 GMT from
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
    return $(".sortable").sortable({
      axis: 'y',
      items: 'li',
      handle: '.points',
      opacity: 0.6,
      scroll: true,
      update: function() {
        return alert("haha");
      }
    });
  });
}).call(this);
