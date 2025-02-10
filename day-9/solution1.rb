FILE_PATH = 'input.txt'
FILE_TEST = 'input_test.txt'

class Solution1
  def read_file
    File.read(FILE_TEST)
  end

  def struct_block(disk_map)
    block = ""
    count = 0
    disk_map.chars.each_with_index do |char, i|
      (0...char.to_i).each do |j|
        if i % 2 == 0
          block += count.to_s
        else
          block += '.'
        end
      end
      if i % 2 == 0
        count += 1
      end
    end
    block
  end

  def find_dot_indexs(block)
    block.chars.each_with_index.select { |char, i| char == '.' }.map(&:last)
  end

  def clean_block(block)
    local_block = block.clone
    dot_indexs = find_dot_indexs(block)

    local_block.chars.each_with_index do |char, i|
      current_last_element = local_block[local_block.length - (i + 1)]
      dot_indexs.each do |dot_index|
        local_block[dot_index] = current_last_element unless current_last_element == '.'
      end
    end

    local_block
  end

  def solve
    disk_map = read_file
    block = struct_block(disk_map)
    cleaned_block = clean_block(block)
    cleaned_block
  end
end

def main
  solution = Solution1.new
  puts solution.solve.inspect
end

main