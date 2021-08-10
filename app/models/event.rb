class Event < ApplicationRecord

    has_many :attendances, foreign_key: 'event_id'
	has_many :attendees, through: :attendances, class_name:'User'
	belongs_to :admin, class_name:'User'

end
