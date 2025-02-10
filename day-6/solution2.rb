FILE_PATH = 'input.txt'
FILE_TEST = 'input_test.txt'

class Solution2
  def build_grid
    @grid = File.readlines(FILE_PATH).map do |line|
      line.chomp.upcase.chars
    end
  end

  def get_starting_index
    @grid.each_with_index do |row, row_index|
      if col_index = row.index('^')
        return [row_index, col_index]
      end
    end
    nil
  end

  def get_candidate_positions
    return Set.new if @grid.empty?

    start_row, start_col = get_starting_index
    candidates_index = Set.new
    @grid.each_with_index do |row, row_index|
      row.each_with_index do |char, col_index|
        candidates_index.add([row_index, col_index]) if [row_index, col_index] != [start_row, start_col] && char == '.'

      end
    end
    candidates_index
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

  def run_simulation(obstacle_index)
    sim_grid = @grid.map(&:dup)
    i, j = obstacle_index
    sim_grid[i][j] = "#"
    row_i, col_i = get_starting_index
    row_count = @grid.length
    col_count = @grid[0].length
    directions = { 'up' => [-1, 0], 'right' => [0, 1], 'down' => [1, 0], 'left' => [0, -1] }
    movement = 'up'

    # Track the guard
    visited_states = Set.new
    visited_states.add([row_i, col_i, movement])

    loop do
      d_row, d_col = directions[movement]
      next_row = row_i + d_row
      next_col = col_i + d_col

      return false if out_of_bounds?(next_row, next_col, row_count, col_count)

      turn = 0
      while sim_grid[next_row][next_col] == "#" && turn < 4
        movement = get_new_direction(movement)
        d_row, d_col = directions[movement]
        next_row = row_i + d_row
        next_col = col_i + d_col
        turn += 1
      end

      return false if out_of_bounds?(next_row, next_col, row_count, col_count)

      # Move to next cells
      row_i, col_i = next_row, next_col

      state = [row_i, col_i, movement]
      if visited_states.include?(state)
        return true
      else
        visited_states.add(state)
      end
    end
  end

  def solve
    build_grid
    candidate_set = get_candidate_positions
    count = 0
    i = 0

    candidate_set.each do |set|
      count += 1 if run_simulation(set)
      i += 1
      puts "Running #{i}"
    end
    count
  end
end

def main
  solution = Solution2.new
  puts solution.solve
end

main