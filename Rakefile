# -*- ruby -*-

require 'rubygems'
require 'hoe'
require "./lib/cocoa-xml/version.rb"

Hoe.plugin :gemcutter
Hoe.plugin :clean
Hoe.plugin :git
Hoe.plugin :yard

Hoe.spec 'cocoa-xml' do
  self.version = ::CocoaXML::Version
  developer('Chris Hoffman', 'cehoffman@gmail.com')

  self.rubyforge_name = 'cocoa-xml'
  
  self.yard_title = "Cocoa-XML"
  self.yard_markup = 'rdoc'
  self.yard_opts = ['--no-private']
  
end

# vim: syntax=ruby
