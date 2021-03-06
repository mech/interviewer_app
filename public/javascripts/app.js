/* DO NOT MODIFY. This file was compiled Fri, 11 Feb 2011 03:54:50 GMT from
 * /Users/mech/Works/Source/interviewer_app/app/coffeescripts/app.coffee
 */

(function() {
  $(function() {
    var bouncePin, sub_hide, sub_show;
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
    $(".drawer form").bind("ajax:complete", function() {
      return $(this).find(".button").val("Save as template");
    });
    $(".drawer form").bind("ajax:beforeSend", function() {
      return $(this).find(".button").val("Saving...");
    });
    $(".template_records .sheet a").bind("ajax:beforeSend", function() {
      var li;
      li = $(this).closest("li");
      li.find("div.sheet").css("opacity", 0.3);
      return li.find(".loading").show();
    });
    $(".template_records .sheet a").bind("ajax:complete", function() {
      var li;
      li = $(this).closest("li");
      li.find("div.sheet").animate({
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
      popover.css("left", $(this).position().left - (parseInt(width) * 0.34));
      popover.toggle();
      return evt.preventDefault();
    });
    $("a.sst").live("click", function(evt) {
      $(".overlay").remove();
      $(".popover-wrap").hide();
      $("div.drawer").slideDown("fast");
      $("div.drawer input.first").focus();
      $("div.drawer input.first").select();
      $("#view").append("<div class='overlay'>");
      $(".overlay").fadeIn("fast");
      $(".overlay").click(function() {
        $(".overlay").fadeOut("fast");
        return $("div.drawer").slideUp("fast");
      });
      return evt.preventDefault();
    });
    $("a.pin_stage").click(function(evt) {
      $.post($(this).attr("href"), {
        "stage_number": $(this).attr("data-stage-number")
      });
      return evt.preventDefault();
    });
    bouncePin = function() {
      return $("span.pinned").fadeIn(100).animate({
        top: "-=10px"
      }, 100).animate({
        top: "+=10px"
      }, 100).animate({
        top: "-=10px"
      }, 100).animate({
        top: "+=10px"
      }, 100).animate({
        top: "-=10px"
      }, 100).animate({
        top: "+=10px"
      }, 100);
    };
    $(".pin_location a.dismiss").click(function(evt) {
      $(".overlay").fadeOut();
      $("div.drawer").slideUp("fast");
      bouncePin();
      evt.preventDefault();
      return history.replaceState(null, "Browser Templates", location.href.replace("?new_pin=yes", ""));
    });
    $(".template_records .sheet").draggable({
      revert: true,
      containment: "#splitview-wrap"
    });
    $("#pinned li a").droppable({
      activeClass: "droppable_active",
      hoverClass: "droppable_hover",
      drop: function(evt, ui) {
        var pin_stage_id, template_id;
        template_id = ui.draggable.attr("id").replace("template_", "");
        pin_stage_id = evt.target.id.replace("pin_stage_", "");
        $(this).effect("pulsate", {
          times: 2
        }, 200);
        return $.post($(this).attr("data-action"), {
          "template_id": template_id,
          "pin_stage_id": pin_stage_id
        });
      }
    });
    $("ul.applicants span.indicator").live("click", function(evt) {
      var li;
      li = $(this).parent().parent();
      li.find(".applicant").toggle();
      return li.toggleClass("open");
    });
    return $(".applicant").live("click", function(evt) {
      $(".applicant").removeClass("active");
      $(this).addClass("active");
      return evt.preventDefault();
    });
  });
}).call(this);
