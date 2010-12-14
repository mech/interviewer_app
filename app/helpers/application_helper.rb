module ApplicationHelper
  def ie_html
    return <<-IE_HTML
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"> <!--<![endif]-->
IE_HTML
  end

  def google_analytics
    return if Rails.env =~ /development|test/
    g_code = <<-GOOGLE
    GOOGLE
  end

  def relative_date(date)
    return if date.blank?
    "#{time_ago_in_words(date)} ago"
  end

  def awesome_truncate(text, length=30, truncate_string="...")
    return if text.blank?
    l = length - truncate_string.chars.to_a.length
    text.chars.to_a.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
end
