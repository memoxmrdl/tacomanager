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
end
