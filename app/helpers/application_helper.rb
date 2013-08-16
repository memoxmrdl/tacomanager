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

  def display_foods(message, options)
    return render options unless @foods.blank?
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

  def display_change_status(order)
    content_tag :li do
      select_tag 'status', options_status(@order.status), id: 'status', class: 'button'
    end if my_object? order
  end

  def display_cancel_order(order)
    content_tag :li do
      button_to "Cancelar orden", dashboard_establishment_order_path, method: :delete, class: 'button'
    end if my_object? order
  end

  def display_remove(order_detail)
    content_tag :div, 'Remover', class: 'remove' if my_object? order_detail
  end

  def display_payment(order_detail)
    content_tag :div, class: 'payment' do
      check_payment order_detail.payment
    end
  end

  def display_edit(establishment)
    if my_object? establishment
      link_to t('.edit'), edit_dashboard_establishment_path, class: 'button'
    end
  end

  def display_add(establishment)
    if my_object? establishment
      link_to t('.add_food'), new_dashboard_establishment_food_path(establishment_id: @establishment.id), class: 'button'
    end
  end

  def my_object?(object)
    object.user == current_identity.user
  end

  def order_payment?
    @order.payment?
  end

  def display_gravatar
    gravatar_image_tag(
      current_identity.user.email.gsub('spam', current_identity.user.nickname),
      alt: current_identity.user.nickname, gravatar: { size: 48 })
  end

  def executed_map(object)
    object.address.latitude && object.address.longitude
  end
end
