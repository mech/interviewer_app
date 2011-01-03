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
  
  $("ul#questions form").bind(
    "ajax:beforeSend",
    ->
      $("ul#questions").animate({opacity: 0.3})
      $("ul#questions .loading").show()
  )

  $("ul#questions form").bind(
    "ajax:complete",
    ->
      $("ul#questions").animate({opacity: 1.0})
      $("ul#questions .loading").hide()
  )

  $("ul#questions input, ul#questions textarea, ul#questions select").live(
    "focus",
    ->
      $(this).closest("li").addClass("active")
  )

  $("ul#questions input, ul#questions textarea, ul#questions select").live(
    "blur",
    ->
      $(this).closest("li").removeClass("active")
  )

  $("ul#questions li").live(
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
      edit_form.fadeIn()

      edit_form.find("a.cancel").click(
        (e) ->
          edit_form.hide()
          details_panel.fadeIn()
          e.preventDefault()
      )

      evt.preventDefault()
  )
