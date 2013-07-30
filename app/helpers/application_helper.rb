module ApplicationHelper
  def display_login_link(&block)
    unless signed_in?
      link_to 'Sign in with Github', '/auth/github'
      #link_to 'Sign in with Twitter', '/auth/twitter'
    else
      html = capture(&block) if block_given?
    end
  end
end
