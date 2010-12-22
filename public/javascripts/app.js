/* DO NOT MODIFY. This file was compiled Wed, 22 Dec 2010 07:22:18 GMT from
 * /Users/mech/Works/Source/interviewer_app/app/coffeescripts/app.coffee
 */

(function() {
  $(function() {
    var sub_hide, sub_show;
    sub_show = function() {
      return $(this).find("ul.sub").show();
    };
    sub_hide = function() {
      return $(this).find("ul.sub").hide();
    };
    return $("nav li").hover(sub_show, sub_hide);
  });
}).call(this);
