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

  def flash_message
    if flash.any?
      if flash.notice
#        return flash.notice
        content_tag(:div, content_tag(:p, flash.notice), :id => "flash_message")
      elsif flash.alert
        content_tag(:div, content_tag(:p, flash.alert.html_safe << (content_tag(:a, "Hide", :href => "/", :class => "dismiss"))), :id => "flash_message")
#        return flash.alert
      end
    end
  ensure
    flash.clear if flash.any?
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

  def interview_datetime(datetime)
    return if datetime.blank?
    "#{datetime.strftime("%b %d")}, #{display_time(datetime)}"
  end

  def display_time(time)
    return nil if time.nil?
    time.acts_like_time? ? time.strftime("%I:%M %p") : ""
  end

  def truncate_words(text, length=30, truncate_string="...")
    return if text.blank?
    l = length - truncate_string.chars.to_a.length
    text.chars.to_a.length > length ? text[/\A.{#{l}}\w*\;?/m][/.*[\w\;]/m] + truncate_string : text
  end
end
