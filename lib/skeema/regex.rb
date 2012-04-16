module Skeema
  class Regex
    attr_reader :schema

    def initialize
      @schema = {}
    end

    def parse(filename)
      File.open(filename).each_line { |line| process_line(line) }
      self
    end

    def process_line(line)
      in_table? ? process_line_in_table(line) : process_line_outside(line)
    end

    def process_line_in_table(line)
      append_columns extract_column_names(line)
      end_table if line.strip == "end"
    end

    def process_line_outside(line)
      table_name = extract_table_name(line)
      start_table(table_name) if table_name
    end

    def extract_table_name(line)
      line.scan(/create_table :(\S+)/).flatten.first
    end

    def extract_column_names(line)
      return [] unless line =~ /^\s*t\.(integer|string|text|boolean|date)/
      without_options = line.split(/(\w+:|:\w+\s*=>)/).first
      without_options.gsub!(/t\.\w+\s+/, '')
      without_options.split(/\,\s*/).map{|c| c.gsub(/:/, '').strip }
    end

    def append_columns(columns)
      @schema[@table] += columns
    end

    def start_table(table_name)
      @table = table_name
      @schema[@table] = []
    end

    def end_table
      @table = nil
    end

    def in_table?
      ! @table.nil?
    end

    def self.parse(filename)
      new.parse(filename).schema
    end
  end
end
