# encoding: utf-8
require "lexer"
class Parser
  attr_reader :root

  def initialize text
    @l = Lexer.new text
  end

  def parse
    @root = @l.next
    @second = @l.next
    raise "parse error" if @root[0] != 'π'
    raise "parse error" if @second[1] != :word
    [@root, [@second]]
  end
end
