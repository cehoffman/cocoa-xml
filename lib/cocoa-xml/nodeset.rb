module CocoaXML
  class NodeSet < Array
    # Collect all the texts of nodes in set and join together
    #
    # @return [String] single string containing text of each element
    def text
      collect { |node| (node.respond_to?(:to_str) && node.to_str) || node.text }.flatten.join
    end
    alias :inner_text :text

    # Collect all the #to_s representations of elements in array
    #
    # @return [String] single string containing #to_s of each element
    def to_s
      collect { |node| node.to_s }.join
    end

    # Perform selector on each element in set
    #
    # @param [String] selector css selector to use on each node
    # @return [NodeSet<NSXMLNode, String>] new set resulting from
    #    performing selector on each node in set
    # @todo This will bomb if the node has String elements in it
    def css(selector)
      xpath ::Nokogiri::CSS::xpath_for(selector, :prefix => ".//").join
    end

    # Perform XQuery on each node in set
    #
    # @param [String] query xquery to perform on each node in set
    # @return [NodeSet<NSXMLNode, String>] results of performing
    #    query
    # @todo This will bomb if the node has String elements in it
    def xquery(query)
      query.sub! %r{^//}, ''    # Root searches to start from nodes
      NodeSet.new(collect { |node| node.xquery(query) }.flatten)
    end

    # Perform XPath selection on each node in set
    #
    # @param [String] path xpath to follow on each node
    # @return [NodeSet<NSXMLNode>] results of path on each node
    # @todo This will bomb if the node has String elements in it
    def xpath(query)
      query.sub! %r{^//}, ''    # Roots searches to start from nodes
      NodeSet.new(collect { |node| node.xpath(query) }.flatten)
    end

    # Get the value of the attribute for each node in set
    #
    # @param [String] attr attribute to search for on each node
    # @return [Array<String, nil>] value of attribute for each node
    def [](attr)
      collect { |node| node[attr] }.flatten
    end
  end
end