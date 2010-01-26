module CocoaXML
  module NSXMLDocumentExtras
    # @private
    def self.included(klass)
      klass.class_eval do
        alias :encoding :characterEncoding
        alias :encoding= :setCharacterEncoding
      end
    end

    # Encoding of document
    #
    # @see http://www.iana.org/assignments/character-sets Valid Encoding Specifiers
    #
    # @return [NSString] encoding of document
    def encoding
      # Implemented as alias to characterEncoding
    end

    # Set encoding of document
    #
    # @see file:///Developer/Documentation/DocSets/com.apple.adc.documentation.AppleSnowLeopard.CoreReference.docset/Contents/Resources/Documents/documentation/Cocoa/Reference/Foundation/Classes/NSXMLDocument_Class/Reference/Reference.html#//apple_ref/occ/instm/NSXMLDocument/setCharacterEncoding: Developer Documentation
    # @see http://developer.apple.com/mac/library/documentation/Cocoa/Reference/Foundation/Classes/NSXMLDocument_Class/NSXMLDocument_Class.pdf Apple NSXMLDocument PDF
    #
    # @param [NSString] enc valid character encoding
    # @return [void]
    def encoding=(enc)
      # Implemented as an alias to setCharacterEncoding
    end

    # Determine if output of document is treated as HTML, e.g. <br> style tags
    def html?
      documentContentKind == NSXMLDocumentHTMLKind
    end

    # Determine if output of document is treated as XHTML, e.g. <br/> style tags
    def xhtml?
      documentContentKind == NSXMLDocumentXHTMLKind
    end

    # Determine if output of document is treated as XML
    def xml?
      documentContentKind == NSXMLDocumentXMLKind
    end
  end
end

::NSXMLDocument.send :include, Cocogiri::NSXMLDocumentExtras
