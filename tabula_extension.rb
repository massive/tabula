# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'
require 'csv'

class TabulaExtension < Radiant::Extension
  version "0.0.1"
  description "Data tables for Radiant"
  url "http://www.posliini.org/tabula"  
  
  define_routes do |map|
     map.namespace :admin, :member => { :remove => :get } do |admin|
       admin.resources :tables
     end
  end
  
  def activate
    admin.tabs.add "Tabula", "/admin/tables", :after => "Layouts", :visibility => [:all]
    Page.send :include, TabulaTags
  end
  
  def deactivate
    # admin.tabs.remove "Tabula"
  end
  
end
