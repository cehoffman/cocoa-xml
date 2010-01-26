module CocoaXML
  # These are a set of methods added onto the Cocoa NSXMLNode class and children.
  module NSXMLNodeExtras
    # Search from this node down using a css selector
    #
    # @param [String] selector selector used to select nodes from document
    # @return [NodeSet<NSXMLNode>] array of nodes matched by selector
    def css(selector)
      xpath ::Nokogiri::CSS::xpath_for(selector, :prefix => ".//").join
    end

    # Search document using provided path
    #
    # @param [String] path path used to select nodes from document
    # @return [NodeSet<NSXMLNode>] array of nodes matched by selector
    def xpath(path)
      error = Pointer.new(:object)
      results = nodesForXPath path, error: error

      return NodeSet.new(results) if error[0].nil?
    end

    # Process document using provided query
    #
    # @param [String] query query used process information in document
    # @return [NodeSet<NSXMLNode, String>] results depends on
    #    query.  Notice that unlike {#xpath} basic types can also be returned.
    def xquery(query)
      error = Pointer.new(:object)
      results = objectsForXQuery query, error: error

      return NodeSet.new(results) if error[0].nil?

      #TODO Do something with the error
    end

    # Get the contained text from this node and children nodes
    #
    # @return [String] text contents of node
    def text
      xquery('data(.)').join
    end
    alias :inner_text :text

    # Get the value of an attribute of node
    #
    # @param [String] attr attribute of node to query
    # @return [String, nil] string value of attribute or nil if no attribute
    def [](attr)
      xquery("data(@#{attr})").pop
    end

    # Set the value of an attribute of node
    #
    # @param [String] attr attribute of node to set
    # @param [#to_s] value value to set attribute to
    # @return ????
    # @todo Find out what this funtion will return
    def []=(attr, value)
      node = attributeForName(attr.to_s)
      node && node.setStringValue(value) || addAttribute(::NSXMLNode.attributeWithName(attr.to_s, stringValue: value))
    end

    # @private
    def attribute(attr)
      attributeForName(attr.to_s)
    end

    # @return [String] the xml of this node including children nodes with proper indentation
    def to_s
      XMLStringWithOptions NSXMLNodePrettyPrint
    end

    # @private
    def self.included(klass)
      klass.class_eval do
        alias :remove :detach
        alias :unlink :detach
        alias :path :XPath

        # TODO: Why is this not working
        alias :old_children :children
        def children
          NodeSet.new(old_children)
        end
      end
    end

    # Remove this node from its parent
    #
    # @return [self] this node
    def remove
      # Implemented as an alias to detach
    end
    alias :unlink :remove

    # An XPath formula to reach this node
    #
    # @return [String] XPath to this node
    def path
      # Implemented as an alias to :XPath
    end
  end
end

::NSXMLNode.send :include, Cocogiri::NSXMLNodeExtras
