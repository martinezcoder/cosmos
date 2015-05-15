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

require 'rails_helper'

RSpec.describe Course, type: :model do

  let(:course) { Course.new(name: "History", summary: "Is the study of the past, particularly how it relates to humans.") }

  it "responds to attributes" do
    expect(course).to respond_to(:name)
    expect(course).to respond_to(:summary)
  end

  describe "validations" do
    it "validates the model" do
      expect(course).to be_valid
    end

    describe "validates parameters" do
      [:name, :summary].each do |field|
        it "validates presence of #{field}" do
          course["#{field}"] = nil
          expect(course).not_to be_valid
        end
      end
    end

  end
end
