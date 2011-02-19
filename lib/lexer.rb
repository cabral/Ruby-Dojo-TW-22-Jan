# encoding: utf-8
class Lexer

  SYMBOLS = {
    "(" => :lpar,
    ")" => :rpar,
    "=" => :eq,
    "π" => :op,
    "σ" => :op,
    "⋈" => :op 
  }

  def initialize string
    @tokens = string.scan(/\(|\)|[^\s()]+/)
  end

  def next
    token = @tokens.shift
    return nil if token.nil?
    [token, SYMBOLS[token] || :word]
  end
end
