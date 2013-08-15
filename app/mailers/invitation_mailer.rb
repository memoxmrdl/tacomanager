class InvitationMailer < ActionMailer::Base
  default from: "notification@tacomanager.com"

  def invitation_order(user, invitate, url_path)
    @user = user
    @invitate = invitate
    @url_invitation = url_path

    mail(to: user.email, subject: 'Has sido invitado a un pedido en TacoManager')
  end
end
