class EventMailer < ApplicationMailer

  def event_status(event_admin, event)
    @event_admin = event_admin
    @event = event
    mail(to: @event_admin.email, subject: 'Info sur votre événement')
  end
end
