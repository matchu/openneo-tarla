module ApplicationHelper
  def include_javascript_in_layout(*scripts)
    scripts.map! do |script|
      if script == :jquery
        'http://ajax.googleapis.com/ajax/libs/jquery/1.4.1/jquery.min.js'
      else
        script
      end
    end
    content_for(:javascripts, javascript_include_tag(*scripts))
  end
  
  def title(title)
    content_for(:title, title)
  end
end
