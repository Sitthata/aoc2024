FILE_PATH = 'input2.txt'

class Solution2
  def read_input
    content = File.readlines(FILE_PATH)
    column1 = get_column(content, 1)
    column2 = get_column(content, 2)

    total_similar_score = 0

    column1.each do |number|
      similarity_score =  number * get_similar_count(number, column2)
      total_similar_score += similarity_score
    end
    total_similar_score
  end

  def get_similar_count(number, column)
    count = 0
    column.each do |value|
      if value == number
        count += 1
      end
    end
    count
  end


  def get_column(content, column)
    if column > 2
      raise ArgumentError, 'Column index out of range'
    end
    content.map { |line| line.split[column - 1].to_i }
  end
end

def main
  solution = Solution2.new
  puts solution.read_input
end

main