require 'rails_helper'

describe 'static_pages' do
  describe 'home page' do
    before :each do
      visit '/static_pages/home'
    end

    it "says 'Ola k ase'" do
      expect(page).to have_selector('h1', text: 'Ola k ase')
    end

    it "has the rigth title" do
      expect(page.title).to eq("Olakase, Home")
    end

  end
end
