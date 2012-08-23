require 'spec_helper'

describe 'Tabbed areas', :type => :helper do
  
  def tabbed_area(opts = {})
    result = helper.tabbed do |tab|
      tab.panel('First Tab', opts) do
        "First tab content"
      end
      tab.panel('Second Tab') do
        "Second tab content"
      end
    end
    result.to_s
  end
  
  let(:result) do
    tabbed_area
  end
  
  it 'adds a .tabbed method' do
    helper.respond_to?(:tabbed).should be_true
  end
  
  describe 'navigation' do
    
    it 'renders a list item for each tab' do
      result.should have_selector('ul > li', :count => 2)
    end
    
    it 'renders a section.tab for each tab' do
      result.should have_selector('section.tab', :count => 2)
    end
    
    context 'when no id is passed to the panel' do
      
      it 'sets the links href to a id formatted string of the title' do
        result.should have_xpath('//a', :href => '#first_tab')
      end
      
    end
    
    context 'when an id is passed to the panel' do
      
      let(:result) do
        tabbed_area(:id => 'tab1')
      end
      
      it 'sets the links href to match the id' do
        result.should have_xpath('//a', :href => '#tab1')
      end
      
    end
    
  end
  
  
end