FILE_PATH = 'input.txt'
WORD = 'XMAS'

class Solution1
  def build_grid
    File.readlines(FILE_PATH).map do |line|
      line.chomp.upcase.chars
    end
  end

  def get_starting_points(grid)
    starting_points = []
    grid.each_with_index do |row_array, i|
      row_array.each_with_index do |char, j|
        starting_points << [i, j] if char == 'X'
      end
    end
    starting_points
  end

  def find_words(starting_point, next_char); end

  def out_of_bounds?(row_i, col_i, row_count, col_count)
    row_i < 0 || row_i >= row_count || col_i < 0 || col_i >= col_count
  end

  def solve
    directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]
    grid = build_grid
    starting_points = get_starting_points(grid)
    col_length = grid.length
    row_length = grid[0].length
    xmas_count = 0

    starting_points.each do |row_index, col_index|
      directions.each do |direction_row, direction_col|
        candidate = ''
        (0...WORD.length).each do |i|
          next_row = row_index + direction_row * i
          next_col = col_index + direction_col * i

          if out_of_bounds?(next_row, next_col, col_length, row_length)
            candidate = nil
            break
          end

          current_char = grid[next_row][next_col]
          candidate << current_char
        end
        xmas_count += 1 if candidate == WORD
      end
    end
    xmas_count
  end
end

def main
  solution = Solution1.new
  puts solution.solve.inspect
end

main
