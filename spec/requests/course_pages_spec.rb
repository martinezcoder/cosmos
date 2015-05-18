require 'rails_helper'

describe "Course pages" do

  subject { page }

  describe "show" do
    let(:course) { FactoryGirl.create(:course) }
    before { visit course_path(course) }

    it { is_expected.to have_selector('h1', text: course.name) }
    it { is_expected.to have_selector('p', text: course.summary) }
  end

  describe "new" do
    before { visit new_course_path }
    let(:submit) { "Create my course" }

    it { is_expected.to have_selector('h1', text: "New Course") }

    describe 'with valid information' do
      before do
        fill_in "Name", with: "Super course"
        fill_in "Summary", with: "this course is about super heroes"
      end

      it "creates a new course" do
        expect { click_button submit }.to change(Course, :count).by(1)
      end
    end

    describe 'with invalid information' do
      before do
        fill_in "Name", with: "a"*51
        fill_in "Summary", with: "some summary"
      end

      it "dont create a new course" do
        expect { click_button submit }.to change(Course, :count).by(0)
      end

      describe "show error messages" do
        before { click_button submit }
        it { is_expected.to have_css('div.alert-danger') }
      end
    end
  end
end
