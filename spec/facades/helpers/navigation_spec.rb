require "spec_helper"

describe Facades::Helpers::Navigation, :type => :helper do
  
  module HelperMethods
    def stub_path(path)
      before do
        helper.controller.request.stubs(:path).returns(path)
      end
    end
  end
  extend HelperMethods
  
  def link(*args)
    resp = helper.nav_link(*['test link', '/home'].concat(args).flatten).to_html
    resp.stubs(:classes).returns((resp.first('a')[:class]  || []))
    resp.stubs(:wrapper).returns(resp.first('li'))
    resp.stubs(:wrapper_classes).returns((resp.first('li')[:class]  || []))
    resp
  end
  
  describe '.nav_link' do      
      
      subject{ link }
        
      it { should have_selector('a') }
      it { should have_selector('li') }
      
      describe 'its class attribute' do
        
        subject{ link.classes }
        
        context 'when the current path' do
          context 'does not match the link path' do
            stub_path('/nothing')
            
            it { should_not include("on") }
          end
          context 'matches the link path' do
            stub_path('/home')
            
            it { should include("on") }
          end
        end
        
        context 'when the current path is a sub-path' do
          context 'and matches the root of the link path' do
            stub_path('/home/child')

            it { should include("on") }
          end
          context 'does not match the root of' do
            stub_path('/nothing/child')

            it { should_not include("on") }
          end
        end
      
        context 'when passed a regex' do          
          
          subject{ link(:matcher => /nothing/i).classes }
          
          context 'matching the request path' do
            stub_path("/nothing")

            it { should include("on") }            
          end
          context 'not matching the request path' do
            stub_path("/massive-fail")
            
            it { should_not include("on") }
          end          
        end
        
        context 'when passed a proc returning true' do 
          
          subject{ link(:proc => lambda{ |path| true }).classes }
          
          it { should include('on') }
        end
        
        context 'when passed a proc returning false' do
          
          subject{ link(:proc => lambda{ |path| false }).classes }
          
          it { should_not include('on') }
        end
        
        context 'with a passed class attribute' do
          describe 'the link' do
            
            subject{ link(:class => 'existing_class', :proc => lambda{ |path| true }).classes }
            
            it { should include('existing_class') }
          end
          
          describe 'the wrapper' do
            
            subject{ link(:wrapper => { :class => 'existing_class' }, :proc => lambda{ |path| true }).wrapper_classes }
            
            it { should include('existing_class') }
          end
        end        
      end
      
    end  
end
