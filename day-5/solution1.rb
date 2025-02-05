FILE_PATH = 'input.txt'
FILE_TEST = 'input_test.txt'

class Solution1
  def read_input
    rules, page_updated = File.read(FILE_TEST).split("\n\n")
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

    puts page_updated[0]
    puts get_applicable_rules(rules, page_updated[0]).inspect

    valid_log = []

    page_updated.each do |page_log|
      applicable_rules = get_applicable_rules(rules, page_log)

      is_valid = applicable_rules.all? do |rule|
        is_rule_valid?(rule, page_log)
      end

      valid_log << page_log if is_valid
    end

    valid_log.map { |page| get_middle_page(page) }.sum
  end
end

def main
  solution = Solution1.new
  puts solution.solve.inspect
end

main
