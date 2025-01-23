class CreateJoinTableUsersInterests < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :interests do |t|
      t.index :user_id
      t.index :interest_id
    end
  end
end
