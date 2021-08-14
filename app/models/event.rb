class Event < ApplicationRecord

	after_update :status

  has_many :attendances, foreign_key: 'event_id'
	has_many :attendees, through: :attendances, class_name:'User'
	belongs_to :admin, class_name:'User'

	def status
	  EventMailer.event_status(User.find(self.admin_id),self).deliver_now
	end

end
