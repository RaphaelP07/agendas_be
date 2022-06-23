class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.send_invite.subject
  #
  def send_invite
    @user = params[:user]
    @meeting = params[:meeting]
    @greeting = "Good day"

    mail(
      to: @user['email'], 
      # cc: 'admin',
      subject: 'Agendas Meeting Invite'
    ) 
  end

  def invite_to_org
    @organisation = params[:organisation]
    @greeting = "Good day"

    mail(
      to: params[:email], 
      # cc: 'admin',
      subject: 'Agendas Organisation Invite'
    ) 
  end
end
