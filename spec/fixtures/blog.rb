ActiveRecord::Schema.define do
  create_table :authors do |t|
    t.string :name, :null => false
  end

  add_index :authors, :name, :unique

  create_table :posts do |t|
    t.integer :author_id, :null => false
    t.string :subject
    t.text :body
    t.boolean :private, :default => false
  end

  add_index :posts, :author_id
end
