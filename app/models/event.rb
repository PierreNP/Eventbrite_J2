class Event < ApplicationRecord

	after_update :status

  has_many :attendances, foreign_key: 'event_id'
	has_many :attendees, through: :attendances, class_name:'User'
	belongs_to :admin, class_name:'User'

  # liens Active Storage
  has_many_attached :event_pictures do |attachable|
    attachable.variant :thumb, resize: "50x50"
  end

	def status
	  EventMailer.event_status(User.find(self.admin_id),self).deliver_now
	end

end
