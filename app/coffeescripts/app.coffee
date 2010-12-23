$ ->
  $("input[type=text]:not(.search):first").focus()

  sub_show = -> $(this).find("ul.sub").show()
  sub_hide = -> $(this).find("ul.sub").hide()

  $("nav li").hover sub_show, sub_hide

  
