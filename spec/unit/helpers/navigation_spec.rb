require 'spec_helper'

describe 'Navigation helpers', :type => :view do

  def stub_path(path)
    view.controller.request.stub!(:path).and_return(path)
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
      rendered.should have_selector(:ul, 
        :count => 1
      )
    end
  
    it 'should create list items for each call to .link' do
      rendered.should have_selector(:li, 
        :count => 2
      )
    end
  
    it 'should create links for each call to .link' do
      rendered.should have_selector(:a, 
        :count => 2
      )
    end
    
  end
  
  describe 'multi-level lists' do
    
    it 'creates a nested list within any link containing a block' do
      render('navigation/multi_list')
      rendered.should have_selector("li > ul")
    end
    
    describe 'active state' do
      
      before do
        stub_path("/about/sub-path")
        render('navigation/multi_list')
      end
      
      it 'adds active to the parent tag' do
        rendered.should have_xpath('//a', 
          :href => '/about', 
          :class => 'active'
        )
      end
      
      it 'adds active to the matching child tag' do
        rendered.should have_xpath('//a', 
          :href => '/about/sub-path', 
          :class => 'active'
        )
      end
      
    end
    
    context 'when no links are passed to the sub-navigation' do
      
      before do
        assign(:subnav, [])
        render('navigation/multi_option_list')
      end
      
      it 'does not render the nested list' do
        rendered.should_not have_selector("li > ul")
      end
    end
    
    context 'when links are passed to the sub-navigation' do
      
      before do
        assign(:subnav, ['Sublink'])
        render('navigation/multi_option_list')
      end
      
      it 'renders the nested list' do
        rendered.should have_selector("li > ul")
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
        assign(:options, { 
          :wrapper => { 
            :id => 'main_navigation' }, 
          :id => 'main_nav_list' 
        })
        render('navigation/single_list')
      end
      
      it 'adds any options passed to :wrapper to the wrapping tag' do
        rendered.should have_xpath('//nav', :id => 'main_navigation')
      end
      
      it 'adds any options passed to the wrapping list' do
        rendered.should have_xpath('//ul', :id => 'main_nav_list')
      end          
    end
    
    context 'when setting :wrapper to false' do
      
      before do
        assign(:options, {
          :wrapper => false
        })
        render('navigation/single_list')
      end
      
      it 'does not render the wrapping nav tag' do
        rendered.should_not(
          have_selector('nav')
        )
      end
    end
  end
      
  describe 'links matching request.path' do
    
    before do
      stub_path("/about")
      render('navigation/single_list')
    end
    
    describe 'by default' do
      
      context 'when the link path matches' do
        
        it 'adds .active to the link matching the path' do
          rendered.should have_xpath('//a', 
            :count  => 1, 
            :href   => '/about', 
            :class  => 'active'
          )
        end
      end # path match
      
      context 'when the link path does not match' do
        
        it 'does not add .active to the link matching the path' do
          rendered.should_not have_xpath('//a', 
            :href => '/', 
            :class => 'active'
          )
        end
      end # mismatch
    end # default
    
    context 'when a proc is passed in the options' do

      context 'and the proc is true' do

        before do
          assign(:link_options, { 
            :home => { 
              :proc => lambda{ |x| true } 
            }})
          render('navigation/single_list')
        end

        it 'adds active to the link' do
          rendered.should have_xpath('//a', 
            :href => '/', 
            :class => 'active'
          )
        end

      end # true proc

      context 'and the proc is false' do

        before do
          assign(:link_options, { 
            :home => { 
              :proc => lambda{ |x| false } 
          }})
          render('navigation/single_list')
        end

        it 'does not active to the link' do
          rendered.should_not have_xpath('//a', 
            :href => '/', 
            :class => 'active'
          )
        end
      end # false proc
    end # proc
    
    context 'when a matcher is passed in the options' do

      context 'and the matcher is a match' do

        before do
          assign(:link_options, { 
            :about => { :matcher => %r{^/about/?} } 
          })
          render('navigation/single_list')
        end

        it 'adds active to the link' do
          rendered.should have_xpath('//a', 
            :href => '/about', 
            :class => 'active'
          )
        end
      end # matches

      context 'and the matcher is not a match' do

        before do
          assign(:link_options, { 
            :home => { :matcher => /^not-home/ }
          })
          render('navigation/single_list')
        end

        it 'does not active to the link' do
          rendered.should_not have_xpath('//a', 
            :href => '/', 
            :class => 'active'
          )
        end
      end # does not match
    end # matcher
  end
  
  describe 'sub-path matching' do
    
    describe 'by default' do
      
      before do
        stub_path("/about/sub-path")
        render('navigation/single_list')
      end
      
      it 'adds .active to the link' do
        rendered.should have_xpath('//a', 
          :href  => '/about', 
          :class => 'active'
        )
      end
    end
    
    describe 'when :match => :exact' do
      
      before do
        assign(:link_options, { 
          :about => { :match => :exact }
        })
      end
      
      context 'and the path exactly matches the url' do
        
        before do
          stub_path("/about")
          render('navigation/single_list')
        end

        it 'adds .active to the link' do
          rendered.should have_xpath('//a', 
            :href  => '/about', 
            :class => 'active'
          )
        end 
      end
      
      context 'and the path does not exactly match the url' do
        
        before do
          stub_path("/about/sub-path")
          render('navigation/single_list')
        end

        it 'does not add .active to the link' do
          rendered.should_not have_xpath('//a', 
            :href  => '/about', 
            :class => 'active'
          )
        end
      end
    end
    
    describe 'when :match => :after' do
      
      before do
        assign(:link_options, { 
          :about => { :match => :after }
        })
      end
      
      context 'and the path matches link + *' do
        
        before do
          stub_path("/prefix/about/sub-path")
          render('navigation/single_list')
        end
        
        it 'adds .active to the link' do
          rendered.should have_xpath('//a', 
            :href  => '/about', 
            :class => 'active'
          )
        end
      end
      
      context 'and the path does not match link + *' do
        
        before do
          stub_path("/prefix/another/sub-path")
          render('navigation/single_list')
        end
        
        it 'does not add .active to the link' do
          rendered.should_not have_xpath('//a', 
            :href  => '/about', 
            :class => 'active'
          )
        end
      end
    end
    
    describe 'when :match => :before' do
      
      before do
        assign(:link_options, { 
          :about => { :match => :before }
        })
      end
      
      context 'and the path matches * + link$' do
        
        before do
          stub_path("/prefix/about")
          render('navigation/single_list')
        end
        
        it 'adds .active to the link' do
          rendered.should have_xpath('//a', 
            :href  => '/about', 
            :class => 'active'
          )
        end
      end
      
      context 'and the path contains text after the match' do
        
        before do
          stub_path("/prefix/about/sub-path")
          render('navigation/single_list')
        end
        
        it 'does not add .active to the link' do
          rendered.should_not have_xpath('//a', 
            :href  => '/about', 
            :class => 'active'
          )
        end
      end
    end
  end
  
end