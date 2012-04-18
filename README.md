# Skeema

Three different implementations of parsing ActiveRecord schema.rb files

## Examples:

    # use the regex-based implementation
    Skeema::Regex.parse('path/to/schema.rb')
    # => { 'authors' => ['name'], 'posts' => ['author_id', 'title', 'body'] }

    # use the instance_eval-based implementation
    Skeema::Pretender.parse('path/to/schema.rb')
    # => { :authors => [:name], :posts => [:author_id, :title, :body] }

    # use the ripper-based implementation
    Skeema::Ripper.parse('path/to/schema.rb')
    # => { :authors => [:name], :posts => [:author_id, :title, :body] }
