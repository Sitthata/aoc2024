FILE_PATH = 'input.txt'
FILE_TEST = 'input_test.txt'

class Solution1
  def build_grid
    File.readlines(FILE_TEST).map do |line|
      line.chomp.upcase.chars
    end
  end

  def get_starting_index(grid)
    grid.each_with_index do |row, row_index|
      if col_index = row.index('^')
        return [row_index, col_index]
      end
    end
    nil
  end

  def out_of_bounds?(row_i, col_i, row_count, col_count)
    row_i < 0 || row_i >= row_count || col_i < 0 || col_i >= col_count
  end

  def get_new_direction(current_movement)
    direction_hash = {
      'up' => 'right',
      'right' => 'down',
      'down' => 'left',
      'left' => 'up'
    }
    direction_hash[current_movement]
  end

  def solve
    grid = build_grid
    row_count = grid.length
    col_count = grid[0].length
    row_i, col_i = get_starting_index(grid)
    directions = { 'up' => [-1, 0], 'right' => [0, 1], 'down' => [1, 0], 'left' => [0, -1] }
    movement = 'up'

    loop do
      # Check the current cell
      current_cell = grid[row_i][col_i]
      # Rotate if hitting an obstacle
      movement = get_new_direction(movement) if current_cell == '#'

      # Compute next position
      d_row, d_col = directions[movement]
      next_row = row_i + d_row
      next_col = col_i + d_col

      # Break if next position is out-of-bounds
      break if out_of_bounds?(next_row, next_col, row_count, col_count)

      # Move to next position
      row_i = next_row
      col_i = next_col
    end
    puts row_i, col_i
    grid[row_i][col_i]
  end
end

def main
  solution = Solution1.new
  puts solution.solve.inspect
end

main
