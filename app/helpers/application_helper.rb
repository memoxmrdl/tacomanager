module ApplicationHelper
  def field_error(model, field)
    if model.errors[field].any?
      content_tag :span, class: 'error-help' do
        model.errors[field].first
      end
    end
  end

  def tr(field)
    t(".#{field}")
  end

  def display_alert
    content_tag :div, class: 'alert' do
      flash.now[:alert]
    end if flash.now[:alert]
  end

  def display_notice
    content_tag :div, class: 'notice' do
      flash[:notice]
    end if flash[:notice]
  end

  def message_empty(msg)
    content_tag :span, msg, class: 'message-empty'
  end

  def display_foods(message)
    return render @foods unless @foods.blank?
    message_empty message
  end

  def display_food_image(object)
    return image_tag object.image.image.url(:small) unless object.image.blank?
    content_tag :div, '', class: 'thumb-empty'
  end

  def build_order_detail(item)
    escape_javascript(render partial: 'dashboard/order_details/order_detail', object: item, as: :order_detail).html_safe
  end

  def options_status(selected)
    selected = 0 if selected.nil?
    options_for_select({ '- Estatus -'=>0, 'Recibido'=>1, 'No llega'=>2, 'No llego'=>3 }, selected)
  end

  def check_payment(payment)
    klass = payment ? 'pay' : 'not_pay'
    content_tag :div, 'Pagado', class: klass
  end

  def render_js(object)
    render = !object ? :active_utilities_order : :disable_utilities_order
    content_for(render)
  end
end
