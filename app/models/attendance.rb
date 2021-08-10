class Attendance < ApplicationRecord

    # after_create :new_attendee_send

	belongs_to :event
	belongs_to :attendee, class_name:'User'

	def new_attendee_send
		UserMailer.event_participation_email(User.find(self.attendee_id), User.find(Event.find(self.event_id).admin_id)).deliver_now
	end

end
