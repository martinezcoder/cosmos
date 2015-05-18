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

    describe "when all is ok" do
      it "course is valid" do
        expect(course).to be_valid
      end
    end

    [:name, :summary].each do |field|
      describe "when #{field} is nil" do
        before { course["#{field}"] = nil }
        it "course is not valid" do
          expect(course).not_to be_valid
        end
      end
    end

    describe "when name is too long" do
      before { course.name = "a" * 51 }
      it "course is not valid" do
        expect(course).not_to be_valid
      end
    end

    describe "when summary is too long" do
      before { course.name = "a" * 256 }
      it "course is not valid" do
        expect(course).not_to be_valid
      end
    end

    describe "when name is already taken" do
      before do
        course_with_same_name = course.dup
        course_with_same_name.save
      end

      it "course is not valid" do
        expect(course).not_to be_valid
      end

    end

  end

end
