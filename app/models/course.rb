# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  summary    :text
#  created_at :datetime
#  updated_at :datetime
#

class Course < ActiveRecord::Base
  validates :name, presence: true
  validates :summary, presence: true
end
