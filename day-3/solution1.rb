FILE_PATH = 'input.txt'

class Solution1
  def read_input
    line = File.read(FILE_PATH)
    line
  end

  def get_matches(line)
    pattern = /mul\((\d{1,3}),(\d{1,3})\)/
    matches = line.scan(pattern)
    matches.map { |x, y| x.to_i * y.to_i }
  end

  def solve
    line = read_input
    get_matches(line).sum
  end
end

def main
  solution = Solution1.new
  puts solution.solve
end

main
