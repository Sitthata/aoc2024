FILE_PATH = 'input.txt'
FILE_TEST = 'input_test.txt'

class Solution1
  def read_input
    File.read(FILE_TEST).split("\n")
  end

  def clean_string(str)
    target, numbers = str.split(":")
    {
      target: target.to_i,
      numbers: numbers.split(" ").map(&:to_i)
    }
  end

  def try_operation(digits)
    len = digits.size
    combination_count = 2 ** (len - 1)
    expressions = []
    (0..combination_count).each do |i|
      expr = digits[0]
      (0..(len - 1)).each do |j|
        if (i >> j) & 1
          op = '+'
        else
          op = '*'
        end
        expressions << expr += op + digits[j + 1]
      end
    end
    expressions
  end
    

  def solve
    content = read_input
    cleaned = content.map { |string| clean_string(string) }
    
    puts cleaned[7]
    try_operation cleaned[7][:numbers]
  end
end

def main
  solution = Solution1.new
  puts solution.solve.inspect
end

main