# encoding: utf-8
require File.dirname(__FILE__) + "/../lib/parser"

describe Parser do
  it "should raise syntax error when text stats without π" do
    lambda do
      p = Parser.new "foo"
      p.parse
    end.should raise_error
  end

  it "should raise syntax error when token after pi isnt a text" do
    lambda do
      p = Parser.new "π π"
      p.parse
    end.should raise_error
  end

  it "should return simple AST containing operator" do
    p = Parser.new "π foo"
    p.parse
    p.root.should == ['π', :op]
  end
  
  it 'π foo should be represented as [["π", :op], [["foo", :word]]]' do
    p = Parser.new "π foo"
    tree = p.parse
    tree.should == [["π", :op], [["foo", :word]]]
  end

  it 'π foo bar should be represented as [["π", :op], [["foo", :word], ["bar", :word]]]' do
    p = Parser.new "π foo bar"
    tree = p.parse
    tree.should == [["π", :op], [["foo", :word], ["bar", :word]]]
  end
end
