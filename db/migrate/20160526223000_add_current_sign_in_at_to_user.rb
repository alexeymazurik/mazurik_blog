class AddCurrentSignInAtToUser < ActiveRecord::Migration
  def change
    rename_column :users, :current_sign_in_a, :current_sign_in_at
  end
end
