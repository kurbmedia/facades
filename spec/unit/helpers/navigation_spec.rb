require 'spec_helper'

describe 'Navigation helpers', :type => :helper do
  
  class << self
    def stub_path(path)
      before do
        helper.controller.request.stub!(:path).and_return(path)
      end
    end
  end
  
  it 'creates a nav method' do
    helper.respond_to?(:nav).should be_true
  end
  
  it 'aliases .navigation to nav' do
    helper.respond_to?(:navigation).should be_true
  end
  
  def generate_nav(options = {}, link_opts = {})
    link_opts[:home] ||= {}
    link_opts[:about] ||= {}
    result = helper.nav(options) do |nav|
      nav.link('Home', '/', link_opts[:home])
      nav.link('About', '/about', link_opts[:about])
    end
    result.to_s
  end
  
  describe 'single level list' do
    
    let(:result) do
      generate_nav
    end
    
    it 'should create a nav element' do
      result.should have_selector(:nav)
    end
  
    it 'should create a single unordered list' do
      result.should have_selector(:ul, :count => 1)
    end
  
    it 'should create list items for each call to .link' do
      result.should have_selector(:li, :count => 2)
    end
  
    it 'should create links for each call to .link' do
      result.should have_selector(:a, :count => 2)
    end
    
  end
  
  describe 'multi-level lists' do
    
    def generate_nav(options = {}, link_opts = {})
      link_opts.reverse_merge!(:home => {}, :about => {}, :sub => {})
      result = helper.nav(options) do |nav|
        nav.link('Home', '/', link_opts[:home])
        nav.link('About', '/about', link_opts[:about]) do |subnav|
          subnav.link('About Sub', '/about/sub-path', link_opts[:sub])
        end
      end
      result.to_s
    end
    
    let(:result) do
      generate_nav
    end
    
    it 'creates a nested list within any link containing a block' do
      result.should have_selector("li > ul")
    end
    
    describe 'active state' do
      
      stub_path("/about/sub-path")
      
      it 'adds active to the parent tag' do
        result.should have_xpath('//a', :href => '/about', :class => 'active')
      end
      
      it 'adds active to the matching child tag' do
        result.should have_xpath('//a', :href => '/about/sub-path', :class => 'active')
      end
      
    end
    
  end
    
  describe 'options' do
    
    context 'when setting :wrapper to a tag' do

      let(:result) do
        generate_nav({ :wrapper => :ol })
      end

      it 'wraps the list in the tag passed to :wrapper' do
        result.should have_selector('nav > ol')
      end

    end # wrapper
    
    context 'when setting options to :wrapper' do
      
      let(:result) do
        generate_nav({ :wrapper => { :id => 'main_navigation' }, :id => 'main_nav_list' })
      end
      
      it 'adds any options passed to :wrapper to the wrapping tag' do
        result.should have_xpath('//nav', :id => 'main_navigation')
      end
      
      it 'adds any options passed to the wrapping list' do
        result.should have_xpath('//ul', :id => 'main_nav_list')
      end          
      
    end # options
    
  end
      
  describe 'links matching request.path' do
    
    let(:result) do
      generate_nav
    end
    
    stub_path("/about")

    it 'adds active to the link matching the path' do
      result.should have_selector('a.active', :count => 1)
      result.should have_xpath('//a', :href => '/about', :class => 'active')
      result.should have_xpath('//li', :class => 'active')
      result.should_not have_xpath('//a', :href => '/', :class => 'active')
    end
    
    it 'does not add active to the link matching the path' do
      result.should_not have_xpath('//a', :href => '/', :class => 'active')
    end
    
  end
  
  context 'when a proc is passed in the options' do
    
    context 'and the proc is true' do
      
      let(:result) do
        generate_nav({}, { :home => { :proc => lambda{ |x| true } } })
      end
      
      it 'adds active to the link' do
        result.should have_xpath('//a', :href => '/', :class => 'active')
      end
      
    end # true proc
    
    context 'and the proc is false' do
      
      let(:result) do
        generate_nav({}, { :home => { :proc => lambda{ |x| false } } })
      end
      
      it 'does not active to the link' do
        result.should_not have_xpath('//a', :href => '/', :class => 'active')
      end
      
    end # false proc
    
  end # proc
  
  context 'when a matcher is passed in the options' do
    
    context 'and the matcher is a match' do
      
      let(:result) do
        generate_nav({}, { :about => { :matcher => /about/ } })
      end
      
      it 'adds active to the link' do
        result.should have_xpath('//a', :href => '/about', :class => 'active')
      end
      
    end # matches
    
    context 'and the matcher is not a match' do
      
      let(:result) do
        generate_nav({}, { :home => { :matcher => /^not-home/ } })
      end
      
      it 'does not active to the link' do
        result.should_not have_xpath('//a', :href => '/', :class => 'active')
      end
      
    end # does not match
    
  end # matcher
  
end