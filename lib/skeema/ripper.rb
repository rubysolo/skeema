require 'ripper'

module Skeema
  class Ripper
    def parse(filename)
      sexp = ::Ripper.sexp IO.read(filename)

      # yay, magic!
      schema_commands = sexp[1][0][2][2]
      @schema = schema_commands.inject({}) do |s, command|
        if command.length > 1
          command_name = command[1][1][1]

          if command_name == "create_table"
            table_name = command[1][2][1][0][1][1][1].to_sym
            columns    = command[2][2].each.map do |col_command|
              col_command[4][1][0][1][1][1].to_sym
            end

            s.merge!(table_name => columns)
          end
        end

        s
      end

      self
    end

    def schema
      @schema
    end

    def self.parse(filename)
      new.parse(filename).schema
    end
  end
end
