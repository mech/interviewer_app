/* DO NOT MODIFY. This file was compiled Mon, 03 Jan 2011 08:56:24 GMT from
 * /Users/mech/Works/Source/interviewer_app/app/coffeescripts/app.coffee
 */

(function() {
  $(function() {
    var sub_hide, sub_show;
    $("input[type=text]:not(.search):first").focus();
    $("ul#questions li.active input.first").focus();
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
        return $.post($("ul#questions").attr("data-sort-url"), $(this).sortable('serialize'));
      }
    });
    $("ul#questions form").bind("ajax:beforeSend", function() {
      $("ul#questions").animate({
        opacity: 0.3
      });
      return $("ul#questions .loading").show();
    });
    $("ul#questions form").bind("ajax:complete", function() {
      $("ul#questions").animate({
        opacity: 1.0
      });
      return $("ul#questions .loading").hide();
    });
    $("ul#questions input, ul#questions textarea, ul#questions select").live("focus", function() {
      return $(this).closest("li").addClass("active");
    });
    $("ul#questions input, ul#questions textarea, ul#questions select").live("blur", function() {
      return $(this).closest("li").removeClass("active");
    });
    $("ul#questions li").live("mouseover mouseout", function(evt) {
      if (evt.type === 'mouseover') {
        return $(this).find(".mode").show();
      } else {
        return $(this).find(".mode").hide();
      }
    });
    return $("ul#questions .mode a.edit").live("click", function(evt) {
      var details_panel, edit_form, entry_panel;
      entry_panel = $(this).closest(".question");
      details_panel = entry_panel.find(".details");
      details_panel.hide();
      edit_form = entry_panel.find(".edit_form");
      edit_form.fadeIn();
      edit_form.find("a.cancel").click(function(e) {
        edit_form.hide();
        details_panel.fadeIn();
        return e.preventDefault();
      });
      return evt.preventDefault();
    });
  });
}).call(this);
