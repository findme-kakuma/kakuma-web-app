module ApplicationHelper
  def nav_link(link_text, link_path, http_method = nil)
    is_current_page = current_page?(link_path)
    unless is_current_page
      lp = if link_path =~ /\A#{URI.regexp(%w(http https))}\z/
             link_path
           else
             request.base_url + link_path
           end
      is_current_page = Rails.application.routes.recognize_path(url_for) ==
                        Rails.application.routes.recognize_path(lp)
    end

    if is_current_page
      class_name = 'active'
      link_content = (
        link_text + '<span class="sr-only">(current)</span>'
      ).html_safe
    else
      class_name = ''
      link_content = link_text
    end

    content_tag(:li, class: class_name) do
      if http_method
        link_to link_path, method: http_method do
          link_content
        end
      else
        link_to link_path do
          link_content
        end
      end
    end
  end
end
