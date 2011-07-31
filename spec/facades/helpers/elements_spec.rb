require "spec_helper"

describe Facades::Helpers::Elements, :type => :helper do

  describe '#button_link' do

    subject{ button_link("home", "/", attrs).to_html }
    let(:attrs){ {} }
    
    it { should have_selector('a.button') }
      
    context 'when passing classes' do
      let(:attrs){ { :class => 'test_class' } }
      
      it { should have_selector('a.test_class') }
    end
      
    context 'when providing an icon' do        
      
      let(:attrs) do 
        { icon: 'sample.png' }
      end
      
      it 'adds an image to the link' do
        subject.should have_selector('img')
      end
      it 'should use the icon attribute as the image' do
        subject.first('img')[:src].should match "sample.png"
      end
    end
      
  end
  
  describe '#flash_messages' do
    
    let!(:flash) do
      { success: 'test flash message' }
    end
    subject{ flash_messages(attrs).to_html }
    
    let(:attrs){ {} }
    
    context 'when rendering normally' do
      
      it 'wraps the content in a div.flash_message' do
        should have_selector('div.flash_message')
      end
      it 'should have a span closer' do
        subject.first('div').should have_selector('span')
      end

      it 'adds the flash key as a html class' do
        should have_selector("div.success")
      end    
      it 'adds :key_flash_message as a html class' do
        should have_selector("div.flash_message_success")
      end
    end
    
    context 'when passed false to :closer' do
      
      let(:attrs) do
        { closer: false }
      end      
      it 'should not add a closer span' do
        subject.first('div').should_not have_selector('span')
      end
    end
    
    context 'when span is passed to :wrapper' do
      
      let(:attrs) do
        { wrapper: :span }
      end
      
      it 'should not use a div wrapper' do
        should_not have_selector('div')
      end
      it 'should have a span wrapper' do
        should have_selector('span.flash_message')
      end
    end    
    
  end
    
end
