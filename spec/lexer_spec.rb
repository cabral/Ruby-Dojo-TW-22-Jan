# encoding: utf-8
require File.dirname(__FILE__) + "/../lib/lexer"

describe Lexer do
  it "should recognize a word as a :word token" do
    l = Lexer.new("this_is_a_word")
    l.next.should == ["this_is_a_word", :word]
    l.next.should == nil
  end

  it "should recognize a operator as a :op token" do
    l = Lexer.new("π")
    l.next.should == ["π", :op]
    l.next.should == nil
  end

  it "should recognize 'foo' as a :word token" do
    l = Lexer.new("foo")
    l.next.should == ["foo", :word]
    l.next.should == nil
  end

  it "should recognize 'σ' as a :op token" do
    l = Lexer.new("σ")
    l.next.should == ["σ", :op]
    l.next.should == nil
  end

  it "should recognize '⋈' as a :op token" do
    l = Lexer.new("⋈")
    l.next.should == ["⋈", :op]
    l.next.should == nil
  end

  it "should recognize an operator and a word together" do
    l = Lexer.new("π foo")
    l.next.should == ["π", :op]
    l.next.should == ["foo", :word]
    l.next.should == nil
  end

  it "should recognize parenthesis as a :lpar and :rpar" do
    l = Lexer.new("( foo )")
    l.next.should == ["(", :lpar]
    l.next.should == ["foo", :word]
    l.next.should == [")", :rpar]
    l.next.should == nil
  end

  it "should recognize equals as :eq" do 
    l = Lexer.new("=")
    l.next.should == ["=", :eq]
    l.next.should == nil
  end

  it "should recognize run-in parenthesis as a :lpar and :rpar" do
    l = Lexer.new("(foo)")
    l.next.should == ["(", :lpar]
    l.next.should == ["foo", :word]
    l.next.should == [")", :rpar]
    l.next.should == nil
  end

  it "should recognize expression" do
    l = Lexer.new("π foo bar (baz ⋈ qux)")
    l.next.should == ["π", :op]
    l.next.should == ["foo", :word]
    l.next.should == ["bar", :word]
    l.next.should == ["(", :lpar]
    l.next.should == ["baz", :word]
    l.next.should == ["⋈", :op]
    l.next.should == ["qux", :word]
    l.next.should == [")", :rpar]
  end

  it "should recognize expression using equals operator" do
    l = Lexer.new("π foo bar σ corge = grault (baz ⋈ qux)")
    l.next.should == ["π", :op]
    l.next.should == ["foo", :word]
    l.next.should == ["bar", :word]
    l.next.should == ["σ", :op]
    l.next.should == ["corge", :word]
    l.next.should == ["=", :eq]
    l.next.should == ["grault", :word]
    l.next.should == ["(", :lpar]
    l.next.should == ["baz", :word]
    l.next.should == ["⋈", :op]
    l.next.should == ["qux", :word]
    l.next.should == [")", :rpar]
  end

end


