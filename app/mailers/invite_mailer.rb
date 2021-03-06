require_dependency 'email_builder'

class InviteMailer < ActionMailer::Base
  include EmailBuilder
  default from: SiteSetting.notification_email
  
  def send_invite(invite)

    # Find the first topic they were invited to
    first_topic = invite.topics.order(:created_at).first

    # If they were invited to a topic
    build_email invite.email,
                'invite_mailer',
                invitee_name: invite.invited_by.username,
                invite_link: "#{Discourse.base_url}/invites/#{invite.invite_key}",
                topic_title: first_topic.try(:title)

  end

end
