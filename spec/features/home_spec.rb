require_relative '../spec_helper'

describe 'Home', :type => :feature, :js => true do

  it 'responds with successful status' do
    visit '/'
    fill_in 'test_string', :with => 'Sandwich'
    fill_in 'gsub_pattern_input', :with => '[wich]+'
    fill_in 'gsub_replacement_input', :with => 'castle'
    expect(page).to have_content 'Sandcastle'
  end
end
