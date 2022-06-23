class InviteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invite_mailer.send_invite.subject
  #
  def send_invite
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
