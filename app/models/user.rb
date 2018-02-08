class User < ApplicationRecord
	has_many :created_events, class_name: "Event", foreign_key: "creator_id"
	has_and_belongs_to_many :attended_events, :class_name => 'Event', :join_table => :events_users


	validates :name, presence: true, length: { in: 4...12 },
              uniqueness: { case_sensitive: false }
  	has_secure_password
  	validates :password, presence: true, length: { minimum: 6 }

  	def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  	end
end
