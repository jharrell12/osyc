module ApplicationHelper

  def render_jumbo_page_title(page_title, subtitle = nil, text = nil)
    content_tag(:div, class: 'p-5 mb-4 bg-light rounded-3') do
      content_tag(:div, class: 'container-fluid py-5') do
        s = content_tag(:h1, page_title, class: 'display-5')
        s << content_tag(:h2, subtitle, class: 'text-danger') if subtitle
        s << content_tag(:p, text, class: 'lead text-danger') if text
        s
      end
    end
  end

  def render_page_title(page_title, subtitle = nil, text = nil)
    content_tag(:div, class: 'alert alert-dark') do
      s = content_tag(:h1, page_title, class: 'display-5')
      s << content_tag(:h2, subtitle, class: 'text-danger') if subtitle
      s << content_tag(:p, text, class: 'text-primary') if text
      s
    end
  end

  def is_splash_page?
    params[:controller] == 'splash' && params[:action] == 'index'
  end


  def new_html_str
    # ''.html_safe
    ActiveSupport::SafeBuffer.new
  end

  def error_message_for_form(msg)
    return '' if msg.nil? 
    header_message = "Error:"
    content_tag(:div, class: :container) do
      content_tag(:div, class: 'alert alert-danger') do
        s = content_tag(:h4, header_message, class: 'alert-heading')
        s << content_tag(:strong, content_tag(:em, msg))
      end
    end
  end

  def error_messages_for(*params)
    options = params.last.is_a?(Hash) ? params.pop.symbolize_keys : {}
    objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
    count   = objects.inject(0) {|sum, object| sum + object.errors.count }
    return '' if count.zero?

    html = {}
    [:id, :class].each do |key|
      if options.include?(key)
        value = options[key]
        html[key] = value unless value.blank?
      else
        html[key] = 'errorExplanation'
      end
    end
    #header_message = "Please correct #{pluralize(count, 'problem')} with this #{(options[:object_name] || params.first).to_s.gsub('_', ' ')} form.".html_safe
    header_message = "Please correct #{(count  = 1 ? 'this problem' : 'these problems')}.".html_safe
    error_messages = safe_join(objects.collect {|object| object.errors.full_messages.map {|msg| content_tag(:li, msg.html_safe) } })

    content_tag(:div, class: :container) do
      content_tag(:div, class: 'alert alert-danger') do
        s = content_tag(:h4, header_message, class: 'alert-heading')
        s << content_tag(:ul, error_messages)
      end
    end
  end

  def flash_class(level)
    bootstrap_alert_class = {
      "success" => "alert-success",
      "error" => "alert-danger",
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "warn" => "alert-warning",
      "warning" => "alert-warning",
    }
    bootstrap_alert_class[level]
  end

  def null_path
    '#'
  end  
end

#NOTES
# https://stackoverflow.com/questions/67655096/bootstrap-5-form-group-form-row-form-inline-not-working
