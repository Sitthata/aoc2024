FILE_PATH = 'input.txt'
FILE_TEST = 'input_test.txt'

class Solution2
  def topological_sort(pages, rules)
    # Step 1: Initialize Graph and In-Degree Hash
    graph = Hash.new { |hash, key| hash[key] = [] } # Adjacency list
    in_degree = Hash.new(0) # Count of incoming edges

    # Initialize in-degree for each page to 0
    pages.each do |page|
      in_degree[page] = 0
    end

    # Step 2: Build the Graph and Compute In-Degrees
    rules.each do |rule|
      from, to = rule
      unless in_degree.key?(from) && in_degree.key?(to)
        raise "Invalid rule: #{from} → #{to}. One of the pages is not in the pages list."
      end

      graph[from] << to
      in_degree[to] += 1
    end

    # Step 3: Initialize Queue with Nodes Having In-Degree 0
    queue = []
    in_degree.each do |page, degree|
      queue << page if degree == 0
    end

    # Initialize the sorted list
    sorted_list = []

    # Step 4: Process Nodes
    until queue.empty?
      current = queue.shift
      sorted_list << current

      # Iterate over all neighbors and reduce their in-degree
      graph[current].each do |neighbor|
        in_degree[neighbor] -= 1
        # If in-degree becomes 0, add to queue
        queue << neighbor if in_degree[neighbor] == 0
      end
    end

    # Step 5: Check for Cycles
    raise 'Cycle detected! Topological sorting not possible.' if sorted_list.size != pages.size

    sorted_list
  end

  def read_input
    rules, page_updated = File.read(FILE_PATH).split("\n\n")
    [rules, page_updated]
  end

  def process_rules(rules)
    rules.split("\n").map do |rule|
      rule.split('|').map do |sub_rule|
        sub_rule.to_i
      end
    end
  end

  def process_page_updated(page_updated)
    page_updated.split("\n").map do |line|
      line.split(',').map do |word|
        word.to_i
      end
    end
  end

  def is_rule_valid?(rule, page_log)
    first_page, second_page = rule
    matching_pages = page_log.filter { |page| page == first_page || page == second_page }
    matching_pages == rule
  end

  def get_middle_page(page_log)
    middle_index = page_log.length / 2
    page_log[middle_index]
  end

  def get_applicable_rules(rules, page_log)
    rules.select do |rule|
      page_log.include?(rule[0]) && page_log.include?(rule[1])
    end
  end

  def solve
    rules, page_updated = read_input
    rules = process_rules(rules)
    page_updated = process_page_updated(page_updated)

    valid_log = []
    invalid_log = []

    page_updated.each do |page_log|
      applicable_rules = get_applicable_rules(rules, page_log)

      is_valid = applicable_rules.all? do |rule|
        is_rule_valid?(rule, page_log)
      end

      valid_log << page_log if is_valid
      invalid_log << get_sorted_invalid_log(page_log, applicable_rules) unless is_valid
    end
    
    invalid_sum = invalid_log.map { |page| get_middle_page(page) }.sum
    invalid_sum
  end
end

def get_sorted_invalid_log(invalid_log, applicable_rules)
  utils = Solution2.new
  utils.topological_sort(invalid_log, applicable_rules)
end

def main
  solution = Solution2.new
  puts solution.solve
end

main
