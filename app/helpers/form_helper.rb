module FormHelper
  #-------------------------------------------------------------------------
  # input forms
  def disable_submit_button
    "my_submit_button.disabled = true; "
  end
  def show_loading_spinner
    "my_loading_spinner.style.visibility = 'visible'; return true; "
  end

  def std_form(url = nil, opt = {}, &block)
    #url = url[:url] if url.is_a?(Hash) && url[:url]
    opt[:method] ||= :put if params[:action] == 'edit'
    opt[:method] ||= :post if params[:action] == 'new'
    opt[:method] ||= :delete if params[:action] == 'delete'
    opt[:method] ||= :post
    opt[:autocomplete] ||= 'off'
    opt[:class] ||= 'form'
    opt[:onsubmit] = disable_submit_button + show_loading_spinner
    form_tag(url, opt) { get_content_body_or_block(nil, &block) }
  end

  def input_form(url = nil, opt = {}, &block)
    opt[:class] ||= 'form-horizontal'
    std_form(url, opt, &block)
  end

  def inline_form(url = nil, opt = {}, &block)
    opt[:class] ||= 'form-inline'
    std_form(url, opt, &block)
  end
  
  # def start_form_remote_tag(action, method = 'POST', target = '', target_message = '')
  #   form_tag(action, method: method, remote: true, autocomplete: 'off', class: 'remote-form', data: { target: target, target_message: target_message })
  # end
  #
  # def submit_form_remote_tag name, caption, url, options = {}
  #   submit_tag(caption, { name: name, type: 'button', class: 'remote-submit-form', data: { url: url } }.deep_merge(options))
  # end

  #-------------------------------------------------------------------------
  # Button formats
  def blue_button(lbl, url, opts = {})
    opts[:class] = 'btn btn-primary mx-1'
    link_to(lbl, url, opts)    
  end

  def blue_outline_button(lbl, url, opts = {})
    opts[:class] = 'btn btn-outline-primary mx-1'
    link_to(lbl, url, opts)
  end

  def submit_button(submit_lbl = nil)
    submit_lbl ||= 'Save'
    button_tag(submit_lbl, class: 'btn btn-success mx-1', name: 'my_submit_button')
  end

  def inline_submit_button(submit_lbl = nil)
    submit_lbl ||= 'Save'
    button_tag(submit_lbl, class: 'btn btn-success ml-3 mr-1 mt-4', name: 'my_submit_button')
  end

  def cancel_button(cancel_lbl = nil, cancel_path = nil, opts = {})
    cancel_lbl ||= 'Cancel'
    cancel_path ||= {action: :index}
    opts[:class] = 'btn btn-outline-danger mx-1'
    link_to(cancel_lbl, cancel_path, opts)
  end

  def add_button(lbl = nil, url = nil, opts = {})
    lbl ||= svg_plus
    url ||= {action: :new}
    opts[:class] = 'btn btn-success mx-1'
    link_to(lbl, url, opts)
  end

  def show_button(lbl, url, opts = {})
    lbl ||= svg_pencil_fill
    opts[:class] = 'btn py-0 btn-outline-info mx-1'
    link_to(lbl, url, opts)
  end

  def edit_button(lbl, url, opts = {})
    lbl ||= svg_pencil_fill + ' Edit'
    opts[:method] = :get
    opts[:class] = 'btn py-0 btn-outline-success mx-2'
    button_to(lbl, url, opts)
  end

  def delete_button(lbl, url, confirm = nil)
    lbl ||= svg_trash_fill + ' Delete'
    opt = {class: 'btn py-0 btn-outline-danger mx-1', method: :delete}
    #FIXED data-confirm does not work in bs5!
    #opt[:data] = {confirm: "Are you sure you want to delete #{confirm}?"} unless confirm.blank?
    opt[:onclick] =  "return confirm('Are you sure you want to delete #{confirm}?');" unless confirm.blank?
    button_to(lbl, url, opt)
  end  

  def filter_button(lbl = nil)
    lbl ||= 'Filter'
    button_tag(lbl, class: 'btn btn-info ml-4 mr-1 mt-4')
  end

  def clear_button(lbl = nil, url = nil)
    lbl ||= 'Clear'
    url ||= {action: :index, 'search[clear]': true}
    link_to(lbl, url, class: 'btn btn-outline-danger mx-1 mt-4')
  end

  def card_link(lbl, url)
    link_to(lbl, url, class: 'card-link')
  end

  def dropdown_divider
    content_tag(:div, nil, class: 'dropdown-divider')
  end

  def dropdown_item_link(lbl, url, opts = {})
    opts[:class] ||= ''
    opts[:class] << ' dropdown-item'
    opts[:class] << ' disabled' if opts[:disabled]
    link_to(lbl, url, opts)
  end

  def dropdown_item_put_link(lbl, url, confirm = nil, opts = {})
    opts[:method] = :put
    opts[:data] = {confirm: "Are you sure you want to #{confirm}?"} unless confirm.blank?
    dropdown_item_link(lbl, url, opts)
  end

  def dropdown_item_post_link(lbl, url, confirm = nil, opts = {})
    opts[:method] = :post
    opts[:data] = {confirm: "Are you sure you want to #{confirm}?"} unless confirm.blank?
    dropdown_item_link(lbl, url, opts)
  end

  def dropdown_item_delete_link(lbl, url, confirm = nil, opts = {})
    opts[:method] = :delete
    opts[:data] = {confirm: "Are you sure you want to delete #{confirm}?"} unless confirm.blank?
    dropdown_item_link(lbl, url, opts)
  end

  def post_link(lbl, url, confirm = nil, opts = {})
    opts[:method] = :post
    opts[:data] = {confirm: "Are you sure you want to #{confirm}?"} unless confirm.blank?
    link_to(lbl, url, opts)
  end

  def plain_link(lbl, url)
    link_to(lbl, url)
  end

  def filter_and_clear_buttons(filter_lbl = nil, clear_lbl = nil, clear_path = nil)
    content_tag(:div, class: :row) { filter_button(filter_lbl) + clear_button(clear_lbl, clear_path) }
  end

  def submit_and_cancel_buttons(submit_lbl = nil, cancel_lbl = nil, cancel_path = nil)
    button_toolbar_div(submit_button(submit_lbl) + cancel_button(cancel_lbl, cancel_path))
  end

  def button_toolbar_div(body = nil, &block)
    div("btn-toolbar mt-2 mb-2", get_content_body_or_block(body, &block))
  end

  def button_group_div(body = nil, &block)
    div("btn-toolbar btn-group-sm", get_content_body_or_block(body, &block))
  end

  def navbar_button_group(body = nil, &block)
    wrap_in(:nav, "navbar navbar-expand-sm btn-group-sm px-0 py-0", get_content_body_or_block(body, &block))
  end

  def loading_spinner(lbl = 'Working...')
    spinner = content_tag(:span, '', class: "spinner-border spinner-border-sm") + lbl
    button_tag(spinner, class: 'btn btn-secondary mx-1', name: 'my_loading_spinner', id: 'my_loading_spinner', style: 'visibility:hidden')
  end

  def blank_space
    content_tag(:div, '&nbsp;'.html_safe)
  end
  
  #-------------------------------------------------------------------------
  # recaptcha fields https://console.cloud.google.com/security/recaptcha
  # style: "transform:scale(0.77);-webkit-transform:scale(0.70);transform-origin:0 0;-webkit-transform-origin:0 0;"
  def recaptcha_checkbox
    div("g-recaptcha", '', {'data-sitekey': Auth.config[:recaptcha_clientkey]} )
  end

  def recaptcha_script_tag
    '<script src="https://www.google.com/recaptcha/api.js" async defer></script>'.html_safe
  end

  #-------------------------------------------------------------------------
  # https://github.com/fingerprintjs/fingerprintjs
  # def fingerprintjs_script
  #   raise 'deprecated'
  #   "
  #   <script>function initFingerprintJS() { FingerprintJS.load().then(fp => { fp.get().then(result => { fingerprint.value = result.visitorId; }); }); }</script>
  #   <script async src='//cdn.jsdelivr.net/npm/@fingerprintjs/fingerprintjs@3/dist/fp.min.js' onload='initFingerprintJS()'></script>
  #   ".html_safe
  # end

  # def browser_fingerprint_field
  #   raise 'deprecated'
  #   '<input type="hidden" name="fingerprint" id="fingerprint">'.html_safe
  # end

  #-------------------------------------------------------------------------
  # search fields
  def search_field_label(str)
    content_tag(:small, str, class: "form-text text-muted")
  end

  def search_field_tag(sym, hint = nil, size = nil)
    opt = {class: 'form-control mr-sm-2'}
    opt[:placeholder] = hint unless hint.nil?
    opt[:size] = size.to_i unless size.nil?
    text_field_tag( "search[#{sym.to_s}]", params[:search][sym], opt )
  end

  def search_select_tag(sym, choices, hint = nil, size = nil)
    opt = {class: 'form-control mr-sm-2'}
    opt[:placeholder] = hint unless hint.nil?
    opt[:include_blank] = true
    select_tag("search[#{sym.to_s}]", options_for_select(choices, params[:search][sym]), opt)
  end

  def labeled_search_field(sym, lbl, size = nil)
    content_tag(:div, class: :col) {search_field_label(lbl) + search_field_tag(sym, lbl, size) }
  end

  def labeled_search_select(sym, lbl, choices)
    content_tag(:div, class: :col) {search_field_label(lbl) + search_select_tag(sym, choices, lbl) }
  end
  #-------------------------------------------------------------------------
  # input fields
  def std_select_field(rec, fld, choices = nil, sopts = {}, hopts = {})
    hopts[:class] ||= 'form-control'
    sopts[:prompt] ||= "Select a #{fld.capitalize}..."
    choices ||= rec.to_s.capitalize.constantize.send("#{fld}_options_for_select")
    select(rec, fld, choices, sopts, hopts )
  end

  def required_select_field(rec, fld, choices = nil, sopts = {}, hopts = {})
    hopts[:required] ||= true
    std_select_field(rec, fld, choices, sopts, hopts)
  end

  def std_date_field(rec, fld, opt = {})
    opt[:class] ||= 'form-control'
    opt[:type] ||= 'date'
    text_field(rec, fld, opt)
  end

  def required_date_field(rec, fld, opt = {})
    opt[:required] ||= true
    std_date_field(rec, fld, opt)  
  end

  def std_number_field(rec, fld, opt = {})
    opt[:class] ||= 'form-control'
    opt[:type] ||= 'number'
    number_field(rec, fld, opt)
  end

  def required_number_field(rec, fld, opt = {})
    opt[:required] ||= true
    std_number_field(rec, fld, opt) 
  end

  def std_text_field(rec, fld, opt = {})
    opt[:class] ||= 'form-control'
    text_field(rec, fld, opt)
  end

  def required_text_field(rec, fld, opt = {})
    opt[:required] ||= true
    std_text_field(rec, fld, opt)  
  end

  def readonly_text_field(rec, fld, opt = {})
    opt[:readonly] ||= true
    std_text_field(rec, fld, opt)
  end

  def plaintext_field(rec, fld, opt = {})
    opt[:readonly] ||= true
    opt[:class] ||= 'form-control-plaintext'
    opt[:size] ||= 100
    std_text_field(rec, fld, opt)
  end  

  def required_password_field(rec, fld, opt = {})
    opt[:required] ||= true
    opt[:class] ||= 'form-control'
    password_field(rec, fld, opt)
  end

  def std_email_field(rec, fld, opt = {})
    opt[:class] ||= 'form-control'
    opt[:placeholder] ||= 'email@example.com'
    email_field(rec, fld, opt)    
  end

  def required_email_field(rec, fld, opt = {})
    opt[:required] ||= true
    opt[:size] ||= 30
    std_email_field(rec, fld, opt)    
  end

  #-------------------------------------------------------------------------
  # cell formatting
  def bold_item(str)
    [str, class: 'fw-bold']
  end

  def small_light_item(str)
    [str, class: 'small fw-light']
  end

  def updated_lbl(str = 'Updated')
    #small_light_item('Updated')
    [str, class: 'small fw-light', width: '1%']
  end

  def updated_by_col(rec)
    [content_tag(:span, rec.updated_at_str.to_utfnb, class: 'small fw-light'), 1]
  end

  #-------------------------------------------------------------------------
  # tables
  def row_col_form(arr)
    out = arr.collect do |row|
      content_tag(:div, class: 'form-row mx-1') do 
        #safe_join(row.collect {|cell| content_tag(:div, cell, class: 'col')})
        safe_join(row)
      end
    end
    safe_join(out)
  end
  #-------------------------------------------------------------------------
  def field_row(row)
    out = row.collect{|cell| content_tag(:div, cell, class: 'col')}
    content_tag(:div, safe_join(out), class: 'form-row')  
  end
  #-------------------------------------------------------------------------
  def input_table_form body = nil, &block
    body = get_content_body_or_block(body, &block)
    content_tag(:div, class: 'form-group mb-2') do 
      content_tag(:table, class: 'table table-borderless') do 
        content_tag(:tbody, body)
      end
    end
  end
  #-------------------------------------------------------------------------
  def page_caption(str)
    data_table_caption str
  end  
  #-------------------------------------------------------------------------
  def case_caption(str)
    s =  content_tag(:div, content_tag(:h4, str,  class: 'font-weight-bold text-info text-nowrap '), class: 'col-8 mt-2')
    content_tag(:div, s, class: :row)
  end
  #-------------------------------------------------------------------------
  def data_table caption, header, body = nil, &block
    body = get_content_body_or_block(body, &block)
    body = '' if body.blank?
    content_tag(:table, class: 'table min table-striped table-bordered table-hover table-sm w-auto') do
      s = new_html_str
      s << content_tag(:caption, caption, style: 'caption-side: top') unless caption.blank?
      s << content_tag(:thead,   header) unless header.blank?
      s << content_tag(:tbody,   body)
    end
  end
  #-------------------------------------------------------------------------
  def data_table_caption(left, right = nil)
    s =  content_tag(:div, content_tag(:h4, left,  class: 'text-primary text-nowrap'), class: 'col-8 mt-2')
    s << content_tag(:div, content_tag(:h4, right, class: 'text-success text_nowrap'), class: 'col-4 mt-2') unless right.blank?
    content_tag(:div, s, class: :row)
  end
  #-------------------------------------------------------------------------
  def field_label_row(item_array)
    content_tag(:tr) do
      a = item_array.collect do |i|
        str, opt = item_to_str_and_opt(i, {scope: 'col'})
        content_tag(:th, str, opt) + "\n"
      end
      safe_join(a)
    end
  end
  #-------------------------------------------------------------------------
  def data_item_row(item_array)
    content_tag(:tr) do
      a = item_array.collect do |i|
        str, opt = item_to_str_and_opt(i)
        content_tag(:td, str, opt) + "\n"
      end
      safe_join(a)
    end
  end  
  #-------------------------------------------------------------------------
  def labeled_data_row(lbl, data)
    content_tag(:tr) do
      lstr, lopt = item_to_str_and_opt(lbl)
      dstr, dopt = item_to_str_and_opt(data)
      content_tag(:td, lstr, lopt) + content_tag(:th, dstr, dopt)
    end
  end
  #-------------------------------------------------------------------------
  def item_to_str_and_opt(i, opt = {})
    if i.class == Array
      str =  i[0].to_s
      opt = opt.merge(i[1].class == Integer ? {width: "#{i[1].to_s}%"} : i[1])
    else
      str = i.to_s
    end
    [str, opt]
  end
  #-------------------------------------------------------------------------
  def empty_row(str)
    content_tag(:tr) { content_tag(:td, content_tag(:em, str), colspan: 99) }
  end  
  #-------------------------------------------------------------------------
  def table_row(str)
    content_tag(:tr, str)
  end  
  #-------------------------------------------------------------------------
  def input_table_row(lbl, str)
    table_row(input_table_pair(lbl, str))
  end
  #-------------------------------------------------------------------------
  def input_table_pair(lbl, str)
    th('text-nowrap pr-2', lbl, scope: :row) + td(nil, str)
  end
  #-------------------------------------------------------------------------
  def labeled_checkbox_pair(lbl, str)
    td(nil, str + lbl , nowrap: true)
  end
  #-------------------------------------------------------------------------
  def thead(style, str, opt=nil)
    wrap_in 'thead', style, str, opt
  end
  #-------------------------------------------------------------------------
  def tr(style, str, opt=nil)
    wrap_in 'tr', style, str, opt
  end
  #-------------------------------------------------------------------------
  def th(style, str, opt=nil)
    wrap_in 'th', style, str, opt
  end
  #-------------------------------------------------------------------------
  def td(style, str, opt=nil)
    wrap_in :td, style, str, opt
  end
  #-------------------------------------------------------------------------
  def div(style, str, opt=nil)
    wrap_in 'div', style, str, opt
  end
  #-------------------------------------------------------------------------
  def br_tag(eol = nil)
    safe_join([eol, tag(:br)])
  end
  #-------------------------------------------------------------------------
  def nbsp
    ' '.to_nbsp.html_safe
  end

  #-------------------------------------------------------------------------
  # general support
  def wrap_in(tag_name, style, str, opt={})
    opt ||= {}
    opt[:class] = style unless style.nil?
    content_tag(tag_name, str.to_s, opt) + "\n"
  end
  #-------------------------------------------------------------------------
  def html_safe &block
    result = yield
    return result.html_safe if result.is_a? String
    return safe_join(result.map{|m| m.to_s.html_safe}) if result.is_a? Array
    result
  end
  #-------------------------------------------------------------------------
  # Flexible block handling.
  def get_content_body_or_block(body, &block)
    raise ArgumentError.new("either body or block expected, not both") if block_given? && !body.nil?
    return body unless body.nil?
    rtrn = yield(body = new_html_str) if block_given?
    body.blank? ? rtrn : body
  end
end