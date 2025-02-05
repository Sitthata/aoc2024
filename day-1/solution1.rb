FILE_PATH = 'input.txt'

class Solution
  def initialize
    @first_column 
  end

  def get_column(content, column)
    if column > 2
      raise ArgumentError, 'Column index out of range'
    end
    content.map { |line| line.split[column].to_i }.sort
  end

  def read_input
    begin
      content = File.readlines(FILE_PATH, chomp: true)
      first_column = get_column(content, 0)
      second_column = get_column(content, 1)
      total_distance = 0
      second_column.each_with_index do |value, i|
        sum = (value - first_column[i]).abs
        total_distance += sum
      end
      total_distance
    rescue Errno::ENOENT
      puts 'Error: Cannot read the content of this file'
      return nil
    end
  end
end

def main
  solution = Solution.new
  content = solution.read_input
  
  puts content
end

main
