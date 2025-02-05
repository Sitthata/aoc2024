FILE_PATH = 'input.txt'
PATTERN = /don\'t\(\)|do\(\)|mul\(\d{1,3},\d{1,3}\)/

class Solution2
  def read_input
    line = File.read(FILE_PATH)
    line
  end

  def get_matches(line)
    matches = line.scan(PATTERN)
    matches
  end

  def process_matches(matches)
    processed = []

    matches.each do |match|
      if match.include?('mul')
        numbers = match.scan(/mul\((\d{1,3}),(\d{1,3})\)/).flatten.map(&:to_i)
        product = numbers.reduce(:*)
        processed << product
      else
        processed << match
      end
    end
    puts processed.inspect
    processed
  end

  def compute(processed_data)
    total = 0
    is_do = true

    processed_data.each do |data|
      if data == "do()"
        is_do = true
      elsif data == "don't()"
        is_do = false
      elsif is_do
        total += data
      end
    end

    total
  end

  def solve
    line = read_input
    input = get_matches(line)
    processed_input = process_matches(input)
    compute(processed_input)
  end
end

def main
  solution = Solution2.new
  puts solution.solve.inspect
end

main