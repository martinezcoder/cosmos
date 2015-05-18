require 'rails_helper'

def fill_form
  fill_in "Name", with: "name"
  fill_in "Summary", with: "some summary"
end

def fill_invalid_form
  fill_in "Name", with: "a"*51
  fill_in "Summary", with: "some summary"
end

shared_examples_for "invalid form" do
  describe "show error messages" do
    before { click_button submit }
    it { is_expected.to have_css('div.alert-danger') }
  end
end

describe "Course pages" do

  let(:submit) { "Save my course" }

  subject { page }

  describe "show" do
    let(:course) { FactoryGirl.create(:course) }
    before { visit course_path(course) }

    it { is_expected.to have_selector('h1', text: course.name) }
    it { is_expected.to have_selector('p', text: course.summary) }
  end

  describe "new" do
    before { visit new_course_path }

    it { is_expected.to have_selector('h1', text: "New Course") }

    describe 'with valid information' do
      before { fill_form }

      it "creates a new course" do
        expect { click_button submit }.to change(Course, :count).by(1)
      end
    end

    describe 'with invalid information' do
      before { fill_invalid_form }

      it "dont create a new course" do
        expect { click_button submit }.to change(Course, :count).by(0)
      end

      it_behaves_like 'invalid form'
    end
  end

  describe "edit" do
    let(:course) { FactoryGirl.create(:course) }
    before { visit edit_course_path(course) }

    describe "page" do
      it { expect(subject).to have_selector('h1', "Edit course") }
    end

    describe 'with valid information' do
      before { fill_form }

      it "saves edited course" do
        click_button submit
        expect(course.persisted?).to be true
      end
    end

    describe 'with invalid information' do
      before { fill_invalid_form }

      it "dont saves edited course" do
        old_name = course.name
        click_button submit
        expect(course.name).to be old_name
      end

      it "remains in the same view" do
        click_button submit
        expect(subject).to have_selector('h1', "Edit course")
      end

      it_behaves_like 'invalid form'
    end
  end

  describe "index" do
    before do
      FactoryGirl.create(:course, name: "course1", summary: "lalal")
      FactoryGirl.create(:course, name: "course2", summary: "lalal")
      visit courses_path
    end

    it { is_expected.to have_selector('h1', text: 'Course list') }

    it "list each course" do
      Course.all.each do |course|
        expect(subject).to have_selector('li', text: course.name)
        expect(subject).to have_link('Edit', href: edit_course_path(course))
      end
    end

    it "have a link to create a new course" do
      expect(subject).to have_selector('a', text: "New course")
    end
  end
end
