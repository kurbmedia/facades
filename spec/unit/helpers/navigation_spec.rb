require 'spec_helper'

describe 'Navigation helpers', :type => :view do

  class << self
    def stub_path(path)
      before do
        view.controller.request.stub!(:path).and_return(path)
      end
    end
  end
  
  it 'creates a nav method' do
    view.respond_to?(:nav).should be_true
  end
  
  it 'aliases .navigation to nav' do
    view.respond_to?(:navigation).should be_true
  end
  
  describe 'single level list' do
    
    before do
      render('navigation/single_list')
    end
    
    it 'should create a nav element' do
      rendered.should have_selector(:nav)
    end
  
    it 'should create a single unordered list' do
      rendered.should have_selector(:ul, :count => 1)
    end
  
    it 'should create list items for each call to .link' do
      rendered.should have_selector(:li, :count => 2)
    end
  
    it 'should create links for each call to .link' do
      rendered.should have_selector(:a, :count => 2)
    end
    
  end
  
  describe 'multi-level lists' do
    
    it 'creates a nested list within any link containing a block' do
      render('navigation/multi_list')
      rendered.should have_selector("li > ul")
    end
    
    describe 'active state' do
      
      stub_path("/about/sub-path")
      
      it 'adds active to the parent tag' do
        render('navigation/multi_list')
        rendered.should have_xpath('//a', :href => '/about', :class => 'active')
      end
      
      it 'adds active to the matching child tag' do
        render('navigation/multi_list')
        rendered.should have_xpath('//a', :href => '/about/sub-path', :class => 'active')
      end
      
    end
    
  end
    
  describe 'options' do
    
    context 'when setting :wrapper to a tag' do
      
      before do
        assign(:options, { :wrapper => :ol })
        render('navigation/single_list')
      end

      it 'wraps the list in the tag passed to :wrapper' do
        rendered.should have_selector('nav > ol')
      end

    end # wrapper
    
    context 'when setting options to :wrapper' do
      
      before do
        assign(:options, { :wrapper => { :id => 'main_navigation' }, :id => 'main_nav_list' })
        render('navigation/single_list')
      end
      
      it 'adds any options passed to :wrapper to the wrapping tag' do
        rendered.should have_xpath('//nav', :id => 'main_navigation')
      end
      
      it 'adds any options passed to the wrapping list' do
        rendered.should have_xpath('//ul', :id => 'main_nav_list')
      end          
      
    end # options
    
  end
      
  describe 'links matching request.path' do
    
    stub_path("/about")
    
    before do
      render('navigation/single_list')
    end
    
    it 'adds active to the link matching the path' do
      rendered.should have_selector('a.active', :count => 1)
      rendered.should have_xpath('//a', :href => '/about', :class => 'active')
      rendered.should have_xpath('//li', :class => 'active')
      rendered.should_not have_xpath('//a', :href => '/', :class => 'active')
    end
    
    it 'does not add active to the link matching the path' do
      rendered.should_not have_xpath('//a', :href => '/', :class => 'active')
    end
    
  end
  
  context 'when a proc is passed in the options' do
    
    context 'and the proc is true' do
      
      before do
        assign(:link_options, { :home => { :proc => lambda{ |x| true } } })
        render('navigation/single_list')
      end
      
      it 'adds active to the link' do
        rendered.should have_xpath('//a', :href => '/', :class => 'active')
      end
      
    end # true proc
    
    context 'and the proc is false' do
      
      before do
        assign(:link_options, { :home => { :proc => lambda{ |x| false } } })
        render('navigation/single_list')
      end
      
      it 'does not active to the link' do
        rendered.should_not have_xpath('//a', :href => '/', :class => 'active')
      end
      
    end # false proc
    
  end # proc
  
  context 'when a matcher is passed in the options' do
    
    context 'and the matcher is a match' do
      
      before do
        assign(:link_options, { :about => { :matcher => /about/ } })
        render('navigation/single_list')
      end
      
      it 'adds active to the link' do
        rendered.should have_xpath('//a', :href => '/about', :class => 'active')
      end
      
    end # matches
    
    context 'and the matcher is not a match' do
      
      
      before do
        assign(:link_options, { :home => { :matcher => /^not-home/ } })
        render('navigation/single_list')
      end
      
      it 'does not active to the link' do
        rendered.should_not have_xpath('//a', :href => '/', :class => 'active')
      end
      
    end # does not match
    
  end # matcher
  
end