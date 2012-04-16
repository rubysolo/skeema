require 'spec_helper'
require 'skeema/ripper'

describe Skeema::Ripper do
  it 'parses an empty schema' do
    described_class.parse(fixture_path "empty.rb").should eq({})
  end

  it 'extracts table info from schema.rb' do
    schema = described_class.parse(fixture_path "blog.rb")
    schema.keys.sort.should eq [:authors,  :posts]
    schema[:posts].should eq [:author_id, :subject, :body, :private]
  end
end
