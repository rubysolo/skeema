require 'spec_helper'
require 'skeema/regex'

describe Skeema::Regex do
  it 'extracts table name from create_table statement' do
    subject.extract_table_name('create_table :authors do |t|').should eq 'authors'
  end

  it 'returns nil as table name for non-matching statements' do
    subject.extract_table_name('t.string :subject').should be_nil
    subject.extract_table_name('add_index :posts, :author_id').should be_nil
  end

  it 'extracts column names from column definitions' do
    subject.extract_column_names('t.string :subject').should eq %w( subject )
    subject.extract_column_names('t.string :subject, :abstract').should eq %w( subject abstract )
    subject.extract_column_names('t.string :subject, :abstract, :null => false').should eq %w( subject abstract )
    subject.extract_column_names('t.string :subject, :abstract, null: false').should eq %w( subject abstract )
  end

  it 'detects start of new table definition' do
    subject.should_receive(:start_table).with('authors')
    subject.process_line('create_table :authors do |t|')
  end

  it 'detects end of table definition' do
    subject.stub(:in_table?).and_return(true)
    subject.stub(:append_columns)

    subject.should_receive(:end_table)
    subject.process_line('  end')
  end

  it 'parses an empty schema' do
    described_class.parse("spec/fixtures/empty.rb").should eq({})
  end

  it 'extracts table info from schema.rb' do
    schema = described_class.parse("spec/fixtures/blog.rb")
    schema.keys.sort.should eq %w( authors posts )
    schema['posts'].should eq %w( author_id subject body private )
  end
end
