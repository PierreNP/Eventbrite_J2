class AddConfirmable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email , :string
    add_column :users, :confirmation_token, :string
  end
end
