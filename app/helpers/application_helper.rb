module ApplicationHelper
  def field_error(model, field)
    if model.errors[field].any?
      content_tag :span, class: 'error_help' do
        model.errors[field].first
      end
    end
  end

  def tr(field)
    t(".#{field}")
  end

  def display_alert
    content_tag :div, class: 'alert' do
      flash[:alert]
    end if flash[:alert]
  end

  def display_notice
    content_tag :div, class: 'notice' do
      flash[:notice]
    end if flash[:notice]
  end
end
