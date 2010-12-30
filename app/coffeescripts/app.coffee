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
      alert "re-ordering..."
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
      $(this).parents("li").addClass("active")
  );

  $("ul#questions input, ul#questions textarea, ul#questions select").live(
    "blur",
    ->
      $(this).parents("li").removeClass("active")
  );
