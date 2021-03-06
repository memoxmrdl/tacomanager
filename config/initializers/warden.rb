Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :omniauth_public
  manager.failure_app = lambda { |env| HomeController.action(:index).call(env) }
end

Warden::Manager.serialize_into_session(:authorization) do |authorization|
  authorization.id
end

Warden::Manager.serialize_from_session(:authorization) do |id|
  Authorization.find(id)
end

Warden::Strategies.add(:omniauth_public) do
  def valid?
    controller_name = request.env['action_dispatch.request.parameters']['controller']
    controller_name == 'sessions'
  end

  def authenticate!
    auth = request.env['omniauth.auth']

    @auth = Authorization.find_from_hash(auth).last || Authorization.create_from_hash(auth)

    return fail! I18n.t('warden.strategies.unauthorized_identity') if @auth.user.blocked?

    success! @auth
  end
end
