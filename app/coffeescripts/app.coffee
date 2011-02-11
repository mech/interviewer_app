$ ->
  $("input[type=text]:not(.search):first").focus()
  $("ul#questions li.active input.first").focus()

  sub_show = -> $(this).find("ul.sub").show()
  sub_hide = -> $(this).find("ul.sub").hide()

  $("nav li").hover sub_show, sub_hide

  $(".sortable").sortable({
    axis: 'y',
    items: 'li',
    handle: '.points',
    opacity: 0.6,
    scroll: true,
    update: ->
      $.post($("ul#questions").attr("data-sort-url"), $(this).sortable('serialize'))
  })
  
  $("li.question form").bind(
    "ajax:beforeSend",
    ->
      li = $(this).closest(".question")
      li.animate({opacity: 0.3})
      li.find(".loading").show()
  )

  $("li.question form").bind(
    "ajax:complete",
    ->
      li = $(this).closest(".question")
      li.animate({opacity: 1.0})
      li.find(".loading").hide()
  )

  $(".drawer form").bind(
    "ajax:complete",
    ->
      $(this).find(".button").val("Save as template")
  )

  $(".drawer form").bind(
    "ajax:beforeSend",
    ->
      $(this).find(".button").val("Saving...")
  )

  $(".template_records .sheet a").bind(
    "ajax:beforeSend",
    ->
      li = $(this).closest("li")
      li.find("div.sheet").css("opacity", 0.3)
      li.find(".loading").show()
  )

  $(".template_records .sheet a").bind(
    "ajax:complete",
    ->
      li = $(this).closest("li")
      li.find("div.sheet").animate({opacity: 1.0})
      li.find(".loading").hide()
  )

  $("ul#questions input, ul#questions textarea, ul#questions select").live(
    "focus",
    ->
      $("li.question").removeClass("active")
      $(this).closest("li").addClass("active")
  )

  $("ul#questions input, ul#questions textarea, ul#questions select").live(
    "blur",
    ->
      $(this).closest("li").removeClass("active")
  )

  $("ul#questions li, table.records td").live(
    "mouseover mouseout",
    (evt) ->
      if evt.type == 'mouseover'
        $(this).find(".mode").show()
      else
        $(this).find(".mode").hide()
  )

  $("ul#questions .mode a.edit").live(
    "click",
    (evt) ->
      entry_panel = $(this).closest(".question")
      details_panel = entry_panel.find(".details")
      details_panel.hide()
      edit_form = entry_panel.find(".edit_form")
      edit_form.slideDown("fast")
      edit_form.find("input.first").focus()

      edit_form.find("a.cancel").click(
        (e) ->
          edit_form.hide()
          details_panel.show()
          e.preventDefault()
      )

      evt.preventDefault()
  )

  $(".question_guide input#stage_points").live(
    "change",
    ->
      $(this).closest("form").submit()
  )

  $(".pop_over").live(
    "click",
    (evt) ->
      popover = $(this).parent().find(".popover-wrap")
      $(".popover-wrap").not(popover).hide()
      width = popover.css("width")
      popover.css("width", width)
      popover.css("left", $(this).position().left - (parseInt(width)*0.34))
      popover.toggle();
      evt.preventDefault()
  )

  $("a.sst").live(
    "click",
    (evt) ->
      $(".overlay").remove()
      $(".popover-wrap").hide()
      $("div.drawer").slideDown("fast")
      $("div.drawer input.first").focus()
      $("div.drawer input.first").select()
      $("#view").append("<div class='overlay'>")
      $(".overlay").fadeIn("fast")
      $(".overlay").click(
        ->
          $(".overlay").fadeOut("fast")
          $("div.drawer").slideUp("fast")
      )
      evt.preventDefault()
  )

  $("a.pin_stage").click(
    (evt) ->
      $.post($(this).attr("href"), {"stage_number": $(this).attr("data-stage-number")})
      evt.preventDefault()
  )

  bouncePin = ->
    $("span.pinned").fadeIn(100).animate({top:"-=10px"},100).animate({top:"+=10px"},100).animate({top:"-=10px"},100).animate({top:"+=10px"},100).animate({top:"-=10px"},100).animate({top:"+=10px"},100)

  $(".pin_location a.dismiss").click(
    (evt) ->
      # TODO - remove query string new_pin=yes
      $(".overlay").fadeOut()
      $("div.drawer").slideUp("fast")
      bouncePin()
      evt.preventDefault()
      history.replaceState(null, "Browser Templates", location.href.replace("?new_pin=yes", ""))
  )

  $(".template_records .sheet").draggable({revert: true, containment: "#splitview-wrap"})

  $("#pinned li a").droppable({
    activeClass: "droppable_active",
    hoverClass: "droppable_hover",
    drop: (evt, ui) ->
      template_id = ui.draggable.attr("id").replace("template_", "")
      pin_stage_id = evt.target.id.replace("pin_stage_", "")
      $(this).effect("pulsate", {times: 2}, 200)
      $.post($(this).attr("data-action"), {"template_id": template_id, "pin_stage_id": pin_stage_id})
  })

  $("ul.applicants span.indicator").live(
    "click",
    (evt) ->
      li = $(this).parent().parent()
      li.find(".applicant").toggle()
      li.toggleClass("open")
  )
