require_relative '../spec_helper'

describe 'Main Page', :type => :feature, :js => true do

  it 'creates correct gsub when given correct syntax' do
    visit '/'
    fill_in 'test_string', :with => '1'
    fill_in 'gsub_pattern_input', :with => '[0-9]+'
    fill_in 'gsub_replacement_input', :with => 'a'
    expect(page.find("#gsub_answer")).to have_content("a")
  end

  it 'shows syntax errors' do
    visit '/'
    fill_in 'test_string', :with => 'Sandwich'
    fill_in 'gsub_pattern_input', :with => '[['
    fill_in 'gsub_replacement_input', :with => 'castle'
    expect(page.find("#gsub_answer")).to have_content("premature end of char-class: /[[/")
  end
end
