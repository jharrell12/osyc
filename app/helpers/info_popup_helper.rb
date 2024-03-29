module InfoPopupHelper
  # -------------------------------------------------------------------------------------
  def info_id_cell(rec, title = nil, columns = nil, size = nil)
    return title if rec.nil?
    title ||= rec.id
    columns ||= rec.class.column_names
    size ||= 'modal-lg'
    element_id = "#{rec.class.name.underscore.to_sym}-#{rec.id}-info"
    info_popup_modal_link(element_id, title) + info_popup_modal(element_id, title, info_content_table(rec, columns, [:params_marshal, :email_body]), size)
  end
  # -------------------------------------------------------------------------------------
  def info_popup_modal_link(element_id, title)
    link_to(title, "##{element_id}", 'data-toggle': 'modal', 'data-target': "##{element_id}")
  end
  # -------------------------------------------------------------------------------------
  def info_popup_modal_button(element_id, title)
    button_tag(title, class: 'btn btn-primary',  'data-toggle': 'modal', 'data-target': "##{element_id}")
  end
  # -------------------------------------------------------------------------------------
  def info_popup_modal(element_id, title, content, size = nil)
    size ||= 'modal-lg'
    content_tag(:div, class: 'modal', id: element_id, tabindex: -1) do
      content_tag(:div, class: "modal-dialog #{size}") do
        content_tag(:div, class: 'modal-content') do
          info_popup_modal_header(title) + info_popup_modal_body(content)
        end
      end
    end
  end
  # -------------------------------------------------------------------------------------
  def info_content_table(rec, fields, omit = [])
    caption = data_table_caption('Class', "#{rec.class.to_s}.find(#{rec.id})")
    data_table(nil, nil) do |s|
      s << field_label_row(['Class', "#{rec.class.to_s}.find(#{rec.id})"])
      fields.each{|f| (s << data_item_row([[f.to_s, 10], rec.send(f).to_s])) unless (omit.include?(f.to_sym) || rec.send(f).to_s.strip.blank?)}
      s << field_label_row(['Class', "#{rec.class.to_s}.find(#{rec.id})"])
    end
  end
  # -------------------------------------------------------------------------------------

  def info_popup_modal_header(title)
    content_tag(:div, class: 'modal-header') do
      content_tag(:h5, title, class: 'modal-title') + button_tag(content_tag(:span, '&times;'.html_safe), class: 'close','data-dismiss': 'modal')
    end
  end

  def info_popup_modal_body(content)
    content_tag(:div, content, class: 'modal-body')
  end

  def info_popup_modal_footer
    content_tag(:div, class: 'modal-footer') { button_tag('Close', class: 'btn btn-outline-primary mx-1', 'data-dismiss': 'modal') }
  end
end
