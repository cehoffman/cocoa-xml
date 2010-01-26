require "cocoa-xml/version"
require "cocoa-xml/nodeset"
require "cocoa-xml/nsxmldocument_extras"
require "cocoa-xml/nsxmlnode_extras"

module CocoaXML
  # Parse an input HTML source
  #
  # @param [url, NSURL, #read, #to_str] source a url as a string or NSURL,
  #   object that responds to #read, or #to_str
  # @return [NSXMLDocument] An NSXMLDocument set to interpret source as HTML
  def self.HTML(source)
    parse source, NSXMLDocumentTidyHTML
  end

  # Parse an input XML source
  #
  # @param [url, NSURL, #read, #to_str] source a url as a string or NSURL,
  #   object that responds to #read, or #to_str
  # @return [NSXMLDocument] An NSXMLDocument set to inperpret source as XML
  def self.XML(source)
    parse source, NSXMLDocumentTidyXML
  end
  
  private
    # Parse an HTML or XML source
    #
    # @param [url, NSURL, #read, #to_str] source a url as a string or NSURL,
    #   object that responds to #read, or #to_str
    # @param [Number] Constant determing how to interpret input source, xml or
    #   html
    # @return [NSXMLDocument]
    def self.parse(source, type)
      error = Pointer.new :object

      url = (source.is_a?(NSURL) && source) || NSURL.URLWithString(source.to_str) if source.respond_to?(:to_str)
      source = source.read if source.respond_to?(:read)

      unless url.nil?
        ::NSXMLDocument.alloc.initWithContentsOfURL url, options: type, error: error
      else
        ::NSXMLDocument.alloc.initWithXMLString source, options: type, error: error
      end
    end
end
