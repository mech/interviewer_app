/* DO NOT MODIFY. This file was compiled Tue, 11 Jan 2011 17:22:29 GMT from
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
    $("li.question form").bind("ajax:beforeSend", function() {
      var li;
      li = $(this).closest(".question");
      li.animate({
        opacity: 0.3
      });
      return li.find(".loading").show();
    });
    $("li.question form").bind("ajax:complete", function() {
      var li;
      li = $(this).closest(".question");
      li.animate({
        opacity: 1.0
      });
      return li.find(".loading").hide();
    });
    $("ul#questions input, ul#questions textarea, ul#questions select").live("focus", function() {
      $("li.question").removeClass("active");
      return $(this).closest("li").addClass("active");
    });
    $("ul#questions input, ul#questions textarea, ul#questions select").live("blur", function() {
      return $(this).closest("li").removeClass("active");
    });
    $("ul#questions li, table.records td").live("mouseover mouseout", function(evt) {
      if (evt.type === 'mouseover') {
        return $(this).find(".mode").show();
      } else {
        return $(this).find(".mode").hide();
      }
    });
    $("ul#questions .mode a.edit").live("click", function(evt) {
      var details_panel, edit_form, entry_panel;
      entry_panel = $(this).closest(".question");
      details_panel = entry_panel.find(".details");
      details_panel.hide();
      edit_form = entry_panel.find(".edit_form");
      edit_form.slideDown("fast");
      edit_form.find("input.first").focus();
      edit_form.find("a.cancel").click(function(e) {
        edit_form.hide();
        details_panel.show();
        return e.preventDefault();
      });
      return evt.preventDefault();
    });
    $(".question_guide input#stage_points").live("change", function() {
      return $(this).closest("form").submit();
    });
    $(".pop_over").live("click", function(evt) {
      var popover, width;
      popover = $(this).parent().find(".popover-wrap");
      $(".popover-wrap").not(popover).hide();
      width = popover.css("width");
      popover.css("width", width);
      popover.css("left", $(this).position().left - (parseInt(width) * 0.33));
      popover.toggle();
      return evt.preventDefault();
    });
    return $("a.drawer").click(function(evt) {
      $("div.drawer").slideToggle("fast");
      $("div.drawer input.first").focus();
      $("#view").append("<div class='overlay'>");
      $(".overlay").fadeIn();
      $(".overlay").click(function() {
        $(".overlay").remove();
        return $("div.drawer").slideUp("fast");
      });
      return evt.preventDefault();
    });
  });
}).call(this);
